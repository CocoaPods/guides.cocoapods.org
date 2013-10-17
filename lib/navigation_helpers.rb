require 'active_support'

module NavigationHelpers

  # The title of the current page. If not specified with YAML
  # Frontmatter it is inferred from the file name.
  #
  # @note This allows to keep the markdown files clean.
  #
  # @return [String] the title.
  #
  def page_title(resource = nil)
    resource ||= current_resource
    
    title = resource.metadata[:page][:page_title]
    title ||= resource.metadata[:page]['title']
    title ||= resource.metadata[:locals][:code_object].name if resource.metadata[:locals][:code_object]
    title ||= resource.metadata[:locals][:name]
    title ||= File.basename(resource.path, ".html").to_s.humanize
    title.to_s.gsub('cocoapods', 'CocoaPods')
  end


  #-----------------------------------------------------------------------------#

  #
  #
  def deserialize(name)
    @cached_doc_datas ||= {}
    @cached_doc_datas[name] ||= YAML::load(File.open("docs_data/#{parameterize name}.yaml"))
  end

  #-----------------------------------------------------------------------------#

  def method_list(name_space, opts)
    result = ""

     columnize(name_space.groups, opts).each_with_index do |column, column_index| 
      column.each_with_index do |entry, index|
        if opts[:absolute_link]
          link = link_for_code_object(entry)
        else
          link = "#" << method_list_entry_fragment(entry, false)
        end

        if entry.is_a?(Pod::Doc::CodeObjects::Group)
          unless column_index == 0 && index == 0
            result << "</ul></li>"
          end
          
          result << "<li><a class='select-tab group' data-toggle='tab' href=#{link}>#{entry.name}</a>"
          result << "<ul class='nav' style='display:none;'>"
        else
          span =  method_list_entry_span(entry)
          result << "<li><a class='select-tab' data-toggle='tab' href=#{link}>#{entry.name}</a>#{span}</li>"
        end
      end

    end
    result
  end

  # FIXME
  def method_list_entry_span(entry)
    case entry
    when Pod::Doc::CodeObjects::GemMethod
      if entry.scope == :class
        value = '+'
      elsif entry.attr_type == 'attribute writer'
        value = 'w'
      elsif entry.attr_type == 'attribute reader'
        value = 'r'
      elsif entry.attr_type == 'readwrite attribute'
        value = 'a'
      end
    when Pod::Doc::CodeObjects::DSLAttribute
      value = 'R' if entry.required?
    end

    "<span class='label label-small'>#{value}</span>" if value
  end

  #-----------------------------------------------------------------------------#

  # @returns the fragment for the URL of a given entry in a method list (group
  # or method).
  #
  def method_list_entry_fragment(entry, external_page = true)
    result = external_page ? "" : 'tab_'
    if entry.is_a?(Pod::Doc::CodeObjects::Group)
      result << "group_"
    elsif entry.is_a?(Pod::Doc::CodeObjects::GemMethod) && entry.scope == :class
      result << "class_"
    end
    result << parameterize(entry.name)
  end

  #-----------------------------------------------------------------------------#

  # Transforms an array of groups in an array of columns, in each column groups
  # and methods are added to the same array.
  #
  # @return [Array<Array<Pod::Doc::CodeObjects>>]
  #
  def columnize(groups, options)
    if sort_order = options[:columns_sort_order_by_page]
      current_page_name = File.basename(current_page.path, '.html')
      group_names_per_column = sort_order[current_page_name]
    end

    if group_names_per_column
      _columnize_manually(groups, group_names_per_column)
    else
      _columnize_algorithmically(groups, options[:only_public], options[:show_empty_groups])
    end
  end

  # Transforms an array of groups in columns
  #
  # @return [Array<Pod::Doc::CodeObjects::Group, Pod::Doc::CodeObjects::Method>]
  #
  def _columnize_manually(groups, group_names_per_column)
    group_names_per_column.map do |column|
      result = []
      column.each do |group_name|
        if group = groups.find { |g| g.name == group_name }
          result << group
          result.concat(group.meths)
        else
          raise "Unable to find group with name: #{group_name}"
        end
      end
      result
    end
  end

  METHOD_LIST_GROUP_HEIGHT       = 44
  METHOD_LIST_FIRST_GROUP_HEIGHT = 22
  METHOD_LIST_METHOD_HEIGHT      = 22

  # Transforms an array of groups in columns
  #
  # @return [Array<Pod::Doc::CodeObjects::Group, Pod::Doc::CodeObjects::Method>]
  #
  def _columnize_algorithmically(groups, only_public, show_empty_groups)
    if only_public
      methods = groups.map(&:meths).flatten.select { |m| m.visibility == :public && !m.inherited }
    else
      methods = groups.map(&:meths).flatten
    end
    # groups = methods.map(&:group).uniq

    groups_and_methods = []
    # methods_by_group = methods.group_by(&:group)
  groups.each do |group|
      if !group.meths.nil? || !group.meths.empty? || show_empty_groups
        groups_and_methods << group
        groups_and_methods.concat(group.meths)
      end
    end

    max_columns      = 4
    groups_height    = groups.count * METHOD_LIST_GROUP_HEIGHT
    methods_height   = methods.count * METHOD_LIST_METHOD_HEIGHT
    total_height     = groups_height + methods_height
    height_percolumn = total_height / max_columns
    min_height       = METHOD_LIST_FIRST_GROUP_HEIGHT + METHOD_LIST_METHOD_HEIGHT
    height_percolumn = min_height unless height_percolumn > min_height

    columns        = []
    current_column = 0
    column_height  = 0
    columns[0]     = []

    groups_and_methods.each do |entry|
      next if entry.is_a?(Pod::Doc::CodeObjects::Group) && !entry.name
      if column_height >= height_percolumn
        column_height = 0
        current_column += 1
        columns[current_column] = []
      end

      if entry.is_a?(Pod::Doc::CodeObjects::Group)
        # move to the next column if it would end up orphan
        if column_height + METHOD_LIST_GROUP_HEIGHT >= height_percolumn && !columns[current_column].empty?
          column_height = 0
          current_column += 1
          columns[current_column] = []
        end
        columns[current_column] << entry
        # groups which are the first entry of a column don't have top-margin.
        column_height += (column_height == 0) ?  METHOD_LIST_METHOD_HEIGHT : METHOD_LIST_GROUP_HEIGHT
      else
        columns[current_column] << entry
        column_height += METHOD_LIST_METHOD_HEIGHT
      end
    end
    columns
  end

  # @return [String] an html anchor for the given object
  #
  def linkify(object, title = nil, base_object = nil)
    if object.is_a?(String)
      object_to_link = search_name_space_by_name(object, base_object)
      if object_to_link
        link  = link_for_code_object(object_to_link)
      end
      title = title || object
    else
      link  = link_for_code_object(object)
      title = title || object.ruby_path
    end
    if link
      link_to(h(title), "#{link}/index.html")
    else
      title
    end
  end

  # @return [String] an html anchor for the given object taking into account
  #         the namespace of another one.
  #
  def linkify_from_obect(object, base_object)
    linkify(object, nil, base_object)
  end

  # Links the references to other objects with the `{A::Reference}` syntax.
  #
  # @return [String] An HTML string.
  #
  # @todo   The URL logic could be moved to the code objects and the
  #         links could be generated after processing the markdown.
  #
  def link_doc_string(html)
    return nil unless html
    html.force_encoding('utf-8').gsub(/\{([^\}]+)\}/) do |match|
      "<code>#{linkify(match[1..-2])}</code>"
    end
  end

  # Finds the name space with the given signature, optionally taking into
  # account the context of an object.
  #
  # @return [Pod::Doc::CodeObjects::NameSpace]
  #
  def search_name_space_by_name(name, base_object = nil)
    if base_object
      siblings = base_object.parent.children
      target = siblings.find { |c| c.is_a?(Pod::Doc::CodeObjects::NameSpace) && c.name.to_s == name }
      return target if target

      parent = base_object
      while parent
        return parent if parent.name.to_s == name
        parent = parent.parent
      end
    end

    components = name.split('::')
    candidates = data.gems.map(&:children).flatten
    # Make inter-gem search work. A bit of an hack but appears to work.
    # E.g. `Specification` from the CocoaPods gem to the CocoaPods-Core gem.
    candidates.concat(candidates.map(&:children).flatten)
    valid      = nil
    count      = 0

    components.each_with_index do |component|
      return nil if candidates.empty?
      valid = candidates.select { |c| c.is_a?(Pod::Doc::CodeObjects::NameSpace) && c.name.to_s == component }
      candidates = valid.map(&:children).flatten
    end

    return nil if valid.empty?
    if valid.map(&:name).uniq.count == 1 && !valid.first.nil?
      valid.first
    else
      raise "#search_name_space_by_name produces ambiguous results: `#{valid.inspect}` for key: `#{name}`."
    end
  end

  # Returns a URL relative to the root for the given code object.
  #
  # @return [String] The url for the given code object.
  #
  def link_for_code_object(code_object)
    chain = [code_object]
    while code_object = code_object.parent
      chain.unshift(code_object)
    end
    r = ''
    chain.each do |object|
      case object
      when Pod::Doc::CodeObjects::Group,
        Pod::Doc::CodeObjects::GemMethod,
        Pod::Doc::CodeObjects::DSLAttribute
        r << '#' << method_list_entry_fragment(object, true)
      else
        r << '/' << parameterize(object.to_s)
      end
    end
    r
  end

  #-----------------------------------------------------------------------------#

  # Regular parametrize creates collisions given Ruby conventions especially
  # because it removes trailing separators.
  #
  # @example
  #
  #   'do'.parametrize  #=> 'do'
  #   'do!'.parametrize #=> 'do'
  #
  def parameterize(object)
    object = object.to_s.downcase
    case object
    when '==' then 'equality'
    when '[]' then 'braces'
    when '+'  then 'plus'
    when '-'  then 'minus'
    when '*'  then 'star'
    else
      object = object.gsub('?','_q_mark')
      object = object.gsub('!','_bang')
      object.gsub(/[^0-9A-Za-z_]/,'_')
    end
  end
end

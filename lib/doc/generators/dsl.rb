module Pod
  module Doc
    module Generators

      # Provides support for describing a DSL.
      #
      class DSL < Base

        def initialize(*args)
          require 'cocoapods-core'
          super
        end

        def yard_object
          yard_registry.at("Pod::#{name}::DSL")
        end

        def generate_code_object
          namespace = CodeObjects::NameSpace.new
          namespace.name = yard_object.parent.name.to_s
          namespace.html_description = markdown_h(yard_object.docstring.to_s)
          namespace.groups = compute_groups
          namespace
        end

        private

        # Finds the group all the method excluding those starting with an `_`.
        # and the attributes readers.
        #
        # @return [Array<Group>]
        #
        def compute_groups
          groups = []

          yard_methods = yard_object.meths.reject do |method|
            name = method.name.to_s
            name =~ /^_/
          end

          yard_methods.each do |yard_method|
            group = groups.find { |g| g.name == group_name_from_text(yard_method.group) }
            unless group
              group = CodeObjects::Group.new
              group.name = group_name_from_text(yard_method.group)
              group.html_description = markdown_h(yard_method.group.lines.drop(1).join)
              group.meths = []
              groups << group
            end


            # TODO: the attr_writer and readers are discerned on a who come first
            # basis.
            method = create_method(yard_method)
            group.meths << method unless group.meths.find { |m| m.name == method.name }
          end
          groups
        end

        # @return [CodeObjects::DSLAttribute]
        #
        def create_method(yard_method)
          method                  = CodeObjects::DSLAttribute.new
          method.name             = yard_method.name.to_s.sub('=','')
          method.html_description = markdown_h(yard_method.docstring.to_s)
          method.examples         = compute_method_examples(yard_method)

          if yard_object.to_s == 'Pod::Podfile::DSL' && method.name == 'install!'
            require 'cocoapods'
            method.html_keys           = installation_options_keys_html
          elsif yard_object.to_s == 'Pod::Specification::DSL' &&
                attribute = Pod::Specification::DSL.attributes[method.name.to_sym]
            method.html_default_values = compute_method_default_values(attribute)
            method.required            = attribute.required?
            method.multi_platform      = attribute.multi_platform?
            method.html_keys           = compute_method_keys(attribute)
          elsif yard_object.to_s == 'Pod::Podfile::DSL'
            method.params = compute_method_params(yard_method)
          end

          method
        end

        # @return [Array<CodeObjects::Example>] The list of the default values of the
        #         attribute in HTML.
        #
        #         In this context the name of the tag is used as the
        #         description.
        #
        def compute_method_examples(yard_method)
          r = yard_method.docstring.tags(:example).map do |e|
            CodeObjects::Example.new(e.name, syntax_highlight(e.text.strip))
          end
          r  unless r.empty?
        end

        # @return [Array<String>] The list of the default values of the
        #         attribute in HTML.
        #
        def compute_method_default_values(attr)
          return nil unless attr
          attr_name = attr.writer_name.gsub('=',' =')
          r = []
          if default_value = attr.default_value
            if default_value.is_a?(Hash) && default_value.keys.sort == [:ios, :osx]
              r << "spec.#{attr_name} #{default_value[:ios].inspect}" if default_value[:ios]
            else
              r << "spec.#{attr_name} #{default_value.inspect}"
            end
          else
            r << "spec.ios.#{attr_name} #{attr.ios_default.inspect}" if attr.ios_default
            r << "spec.osx.#{attr_name} #{attr.osx_default.inspect}" if attr.osx_default
          end
          r.map { |v|  syntax_highlight(v) } unless r.empty?
        end

        # @return [Array<String>] The list of the keys accepted by the
        #         attribute in HTML.
        #
        def compute_method_keys(attribute)
          keys = attribute.keys || []
          keys = if keys.is_a?(Hash)
            new_keys = []
            keys.each do |key, subkeys|
              if subkeys && !subkeys.empty?
                subkeys = subkeys.map { |key| code_for_key(key) }
                new_keys << "#{code_for_key(key)} => #{subkeys * ", "}"
              else
                new_keys << code_for_key(key)
              end
            end
            new_keys
          else
            keys.map { |key| code_for_key(key) }
          end
          keys.map { |k| markdown_h(k) }
        end

        def compute_method_params(yard_method)
          params_or_nil = yard_method.docstring.tags.map do |tag|
            next if tag.tag_name.to_sym != :param
            html = markdown_h(tag.text)

            Pod::Doc::CodeObjects::Param.new(tag.name, tag.types, html)
          end

          params_or_nil.reject(&:nil?)
        end

        def installation_options_keys_html
          Pod::Installer::InstallationOptions.all_options
            .map { |o| markdown_h(code_for_key(o)) }
        end

        def code_for_key(key)
          "`:#{key}`"
        end

        # @return [String]
        #
        def group_name_from_text(group_text)
          group_text.lines.first.chomp.gsub('DSL: ','')
        end

      end

    end
  end
end

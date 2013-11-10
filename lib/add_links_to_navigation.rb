# Require core library
require "middleman-core"
require "nokogiri"

# Our markdown parser gives us an id to each header ( which is cool ) but we also need an anchor in there for selection
# which means we have to do it all ourselves.

module AddLinksToNavigation
  class << self

    def registered(app, options={})

      app.after_render do |body, path, locs, template_class|
        
        # we get multiple render calls due to markdown / slim doing their thing
        # 
        if (template_class.to_s.index "Slim") != nil or (path.to_s.index "templates") != nil     
                 
          doc = Nokogiri::HTML(body)
          doc.css(".content h2, .content h3").each do |header|
            if header.attributes["id"]
              header.inner_html = "<a class='header-link' href='\##{header.attributes["id"]}'>&lt;</a>" + header.inner_html
            end
          end
        
          doc.to_s
        else           
          body
        end

      end
    end
    alias :included :registered
  end
end

::Middleman::Extensions.register(:add_links_to_navigation) do
  ::AddLinksToNavigation
end
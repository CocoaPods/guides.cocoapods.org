# Require core library
require "middleman-core"

# We want all code blocks to have a full width white bg, and we don't want to have shitty code
# so we pre-parse every page replacing the pre for a code block with the close / opening

module BreakingSource
  class << self

    def registered(app, options={})

      app.after_render do |body, path, locs, template_class|
        
        pre = <<-eos      
  </article>
  </section>
  
  <div style="background-color:white;">
  <section class="row container">
  <article class="content col-md-8 col-md-offset-2"><pre
        eos

        post = <<-eos              
  </pre></article>
  </section>
  </div>
  
  <section class="container row">
  <article class="content col-md-8 col-md-offset-2">
        eos
        
        body = body.gsub(/<pre/, pre)
        body = body.gsub(/<\/pre>/, post)
      end

    end
    alias :included :registered
  end
end

::Middleman::Extensions.register(:breaking_source) do
  ::BreakingSource
end
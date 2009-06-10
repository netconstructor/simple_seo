module SimpleSEO
  module Controller
    def self.included(base)
      base.before_filter :load_simple_seo
    end
    
    def load_simple_seo
      path = File.join(Rails.root, "config", "seo.yml")
      seo = open(path, 'r'){|f| YAML::load(f) } if File.exist?(path)

      if defined?(seo)
        [:title, :keywords, :description].each do |name|
          ivar = "@content_for_#{name.to_s}"
          content = seo["#{controller_name}_#{action_name}"][I18n.locale.to_s][name.to_s]
          instance_variable_set(ivar, "#{instance_variable_get(ivar)}#{content}")      
        end
      end
    end
  end
  
  module Helper
    def seotags(options = {})
      title = [@content_for_title, options[:title_connector], options[:default_title]]
      str = "<title>#{options[:title_reverse] ? title.reverse.join(" ") : title.join(" ")}</title>\n"
      str += meta("keywords", @content_for_keywords)
      str += meta("description", @content_for_description)
      str
    end
    
    def meta(name, content)
      %(<meta name="#{name}" content="#{content}" />\n)
    end
  end
end

ActionController::Base.send(:include, SimpleSEO::Controller)
ActionView::Base.send(:include, SimpleSEO::Helper)
module SimpleSEO
  module Controller
    def self.included(base)
      base.before_filter :load_simple_seo
    end
    
    protected
    def load_simple_seo
      path = File.join(Rails.root, "config", "seo.yml")
      @file = open(path, 'r'){|f| YAML::load(f) } if File.exist?(path)

      unless @file.nil?
        [:title, :keywords, :description].each do |name|
          ivar = "@content_for_#{name.to_s}"
          content = content_seo_for(name)
          instance_variable_set(ivar, "#{instance_variable_get(ivar)}#{content}")      
        end
      end
    end
    
    def content_seo_for(name)
      keys = values.nil? ? @file["default"] : values

      begin
        res = ""
        res += "#{keys[name.to_s]}"
        res += "#{keys[I18n.locale.to_s][name.to_s]}"
      rescue
        # Don't exist any information about seo for this action/controller
      end
    end
    
    def values
      if controller_name == @file["static"]["controller"] && action_name == @file["static"]["action"]
        @file["#{controller_name}_#{params[@file["static"]["view"].to_sym]}"]
      else
        @file["#{controller_name}_#{action_name}"]
      end
    end    
  end
  
  module Helper
    def metatags(options = {})
      title = [@content_for_title, options[:default_title]]
      title.reverse! if options[:title_reverse]
            
      str = "<title>" + title.join(" #{options[:title_connector]} ") + "</title>\n"
      str += meta("keywords", @content_for_keywords)
      str += meta("description", @content_for_description)
    end
        
    def meta(name, content)
      %(<meta name="#{name}" content="#{content}" />\n)
    end
    
    def add_meta_for(name, content)
      eval("@content_for_#{name.to_s} += content")
    end
  end
end

ActionController::Base.send(:include, SimpleSEO::Controller)
ActionView::Base.send(:include, SimpleSEO::Helper)
module SimpleSEO
  def self.included(base)
    base.before_filter :load_simple_seo
  end
    
  def load_simple_seo
    path = File.join(Rails.root, "config", "seo.yml")
    seo = open(path, 'r'){|f| YAML::load(f) } if File.exist?(path)
    
    if defined?(SEO)
      [:title, :keywords, :description].each do |name|
        ivar = "@content_for_#{name.to_s}"
        content = seo["#{controller_name}_#{action_name}"][I18n.locale.to_s][name.to_s]
        instance_variable_set(ivar, "#{instance_variable_get(ivar)}#{content}")      
      end
    end
  end
end


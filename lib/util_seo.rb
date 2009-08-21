module UtilSEO
  def add_meta_for(name, content)
    eval("@content_for_#{name.to_s} = 
      [@content_for_#{name.to_s}, content[locale.to_sym]].reject{|x| x.blank?}.join(', ')")
  end
  
  def locale
    params[:locale] || session[:locale] || I18n.locale
  end
end


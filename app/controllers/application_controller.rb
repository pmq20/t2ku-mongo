# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  include UrlHelper

  before_filter :set_locale,:view_no,:login_reg
  before_filter proc{
    # render text:headers and return
  }
  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  end
  
  def view_no
    pos = "#{params[:controller]}_#{params[:action]}"
    @no = Hash.new
    if 'home_index'==pos
      @no[:headnav] = @no[:footer] = true
    end
    if params[:controller].to_s.start_with?('devise')
      @no[:footer] = true
    end
  end
    
  def login_reg
    if !user_signed_in?
      @new_user = User.new 
    end
  end
  
  def after_sign_in_path_for(resource_or_scope)
    if params[:redirect_to].blank?
      super(resource_or_scope)
    else
      params[:redirect_to]
    end
  end
  
  def render_optional_error_file(status_code)
    render :template => "/errors/#{status_code}.html.erb", :status => status_code, :layout => "application"
  end


  # Get locale code from request subdomain (like http://it.application.local:3000)
  # You have to put something like:
  # 127.0.0.1 en.t2ku.org.local
  # 127.0.0.1 zh.t2ku.org.local
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    parsed_locale = 'zh-CN' if 'zh'==parsed_locale
    return nil if nil==parsed_locale
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
  end

end

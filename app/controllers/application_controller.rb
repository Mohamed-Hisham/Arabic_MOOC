class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # # remove the locale from url if the default is chosen already
  def default_url_options(options={})
    (I18n.locale.to_sym.eql?(I18n.default_locale.to_sym) ? {} : {locale: I18n.locale})
  end

  def after_sign_in_path_for(resource)
    case resource.class.name.underscore.to_sym
    when :admin
      admin_path(current_admin)
    when :user
      root_path
    end
  end
end

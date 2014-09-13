class Users::Devise::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

   protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :gender
    devise_parameter_sanitizer.for(:sign_up) << :avatar
  end
end
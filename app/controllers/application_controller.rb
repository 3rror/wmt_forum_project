class ApplicationController < ActionController::Base
  include Pundit
  include Pagy::Backend # Move this?

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end
end

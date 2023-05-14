class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  # after_action :set_flash_message, if: :devise_controller?, only: :destroy

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  # def set_flash_message
  #   if request.method == "DELETE"
  #     flash[:notice] = "Signed out successfully."
  #   end
  # end

end
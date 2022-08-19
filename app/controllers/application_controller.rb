class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[username name email password password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in,
                                      keys: %i[login password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[username name email password_confirmation current_password])
  end

  private

  def set_current_user
    Current.user = current_user
  end
 
  
  # def current_user
  #   # If test situation when user is logged in
  #   User.first

  #   # If test situation when user is not logged in
  #   # nil
  # end

end

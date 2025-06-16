class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include SessionsHelper
  before_action :require_login
  helper_method :logged_in?, :current_user

  def require_login
    unless logged_in?
      flash[:alert] = "Tu dois être connecté pour accéder à cette page."
      redirect_to login_path
    end
  end
end

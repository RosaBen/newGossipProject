module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  private

  def login(user)
    session[:user_id] = user.id
  end
end

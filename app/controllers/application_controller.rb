class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  # get the current user from browser session
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  # determine if current user exists
  def logged_in?
    !!current_user
  end
  
  def require_user
    # invalid user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action"
      redirect_to root_path
    end
  end

end

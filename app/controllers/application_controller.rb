class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Methods available everywhere
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  #Methods only available in controllers
  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to root_path
    end
  end

  def require_ownership(id)
    if !logged_in? || !(current_user.id == id)
      flash[:error] = "You're not allowed to do that."
      redirect_to root_path
    end
  end
end

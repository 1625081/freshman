class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  protected
  def authericate_user!
    if ! session[:user_id]
      redirect_to :root
    end
  end

end

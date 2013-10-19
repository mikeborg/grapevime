class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authorize # this needs to return status 401 - alter the JS to handle a 404.
    render( :nothing => true, :status => :unauthorized) if current_user.nil?
  end
  
end

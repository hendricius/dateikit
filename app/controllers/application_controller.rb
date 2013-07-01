class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_auth_token
  before_filter :check_auth_token

  def set_auth_token
    if params[:token]
      cookies[:token] = params[:token]
    end
  end

  def check_auth_token
    if cookies[:token] != ENV["SECRET_KEY_MANAGE_FILES"]
      flash[:error] = "You shall not pass"
      redirect_to root_path
      false
    end
  end
end

class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  helper_method :account_signed_in?, :current_account

  protected

  def authenticate_account
    cookies.delete(:username) && redirect_to(root_url) if current_account.blank?
  end

  def current_account
    @current_account ||= User.find_by(username: cookies.signed[:username])
  end

  def account_signed_in?
    current_account.present?
  end
end

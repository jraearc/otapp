class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :redirect_to_https

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

  def redirect_to_https
    redirect_to :protocol => "https://" unless (request.ssl? || request.local?)
  end
end

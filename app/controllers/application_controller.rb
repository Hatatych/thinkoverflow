class ApplicationController < ActionController::Base
  # before_action :require_authentication

  private

  def require_authentication
    redirect_to root_path and return unless user_signed_in?
  end
end

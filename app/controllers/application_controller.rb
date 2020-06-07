class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(error)
    redirect_to(request.referrer || root_path, alert: "I'm sorry#{' ' + current_user.first_name}, I'm afraid you can't do that. #{error.policy.message}")
  end
end

class EnvironmentPolicy < ApplicationPolicy
  def index?
    return false if @user.nil?

    @user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

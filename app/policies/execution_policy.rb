class ExecutionPolicy < ApplicationPolicy
  def index?
    return false if @user.nil?

    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

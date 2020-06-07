class ScriptPolicy < ApplicationPolicy
  def action?
    return true
    return false if @user.nil?
    return false if @record.expired?

    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

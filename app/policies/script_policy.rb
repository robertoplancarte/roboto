class ScriptPolicy < ApplicationPolicy
  def action?
    return true
    return false if @user.nil?

    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

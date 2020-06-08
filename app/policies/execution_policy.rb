class ExecutionPolicy < ApplicationPolicy
  def action?
    return false if @user.nil?

    if !@user.admin? && @record.expired?
      @message = "Can't modify expired executions."
      return false
    end

    if @record.environment.name == 'production'
      @message = 'Only developers or admins can aprove executions in production'
      return if !@user.admin? || !@user.developer

      @message = "I can't run untested scripts in production!"
      return false if %w[new untested].include? @record.script.aasm_state
    end

    true
  end

  def update?
    false
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

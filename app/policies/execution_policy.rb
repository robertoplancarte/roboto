class ExecutionPolicy < ApplicationPolicy
  def action?
    return true if @user.admin?

    return false if @user.nil?

    if @record.expired?
      @message = "I can't run expired executions!"
      return false
    end

    if @record.environment.name == 'production'
      @message = "I can't run untested scripts in production!"
      return false if %w[new untested].include? @record.script.aasm_state
    end

    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

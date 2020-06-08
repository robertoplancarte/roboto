class ApplicationPolicy
  attr_accessor :message
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
    @message = ""
  end

  def index?
    return false if @user.nil?

    @user.tester? || @user.admin?
  end

  def show?
    return false if @user.nil?

    @user.tester? || @user.admin?
  end

  def create?
    return false if @user.nil?

    @user.admin?
  end

  def new?
    create?
  end

  def update?
    return false if @user.nil?

    @user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    return false if @user.nil?

    @user.admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end

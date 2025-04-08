class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
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

  def admin?
    user&.admin?
  end

  def sprint_admin?
    user&.sprint_admin?
  end

  def task_admin?
    user&.task_admin?
  end

  def user?
    user&.user?
  end
end

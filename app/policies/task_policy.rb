class TaskPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    admin? || sprint_admin? || task_admin?
  end

  def new?
    create?
  end

  def update?
    admin? || sprint_admin? || task_admin?
  end

  def edit?
    update?
  end

  def destroy?
    admin? || sprint_admin? || task_admin?
  end

  def delete?
    destroy?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

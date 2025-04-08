class AttachmentPolicy < ApplicationPolicy
  def destroy?
    admin? || sprint_admin? || task_admin?
  end

  def create?
    admin? || sprint_admin? || task_admin?
  end
end

class TaskBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :description, :status, :due_date

  association :assignee, blueprint: UserBlueprint, name: :assignee, if: ->(task, _) { task.assignee.present? }
end

class TaskBlueprint < Blueprinter::Base
  identifier :id

  view :minimal do
    fields :name, :status
  end

  view :detailed do
    fields :name, :description, :status, :due_date

    association :assignee, blueprint: UserBlueprint
  end
end

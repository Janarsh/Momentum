class SprintBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :start_date, :end_date

  association :tasks, blueprint: TaskBlueprint
end

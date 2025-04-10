class ProjectBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description

  association :sprints, blueprint: SprintBlueprint
end

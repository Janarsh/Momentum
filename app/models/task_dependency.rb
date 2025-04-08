class TaskDependency < ApplicationRecord
  belongs_to :dependent_task, class_name: "Task"
  belongs_to :dependency_task, class_name: "Task"
end

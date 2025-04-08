class Task < ApplicationRecord
  belongs_to :sprint
  belongs_to :assignee, class_name: "User", optional: true
  belongs_to :created_by, class_name: "User"
  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy
  has_many :task_dependencies, foreign_key: :dependent_task_id, dependent: :destroy

  enum task_type: { epic: "epic", story: "story", bug: "bug", task: "task", spike: "spike" }
  enum status: { open: "open", in_progress: "in_progress", resolved: "resolved", closed: "closed" }
  enum priority: { high: "high", low: "low", normal: "normal" }

  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.status ||= :open
    self.priority ||= :low
  end
end

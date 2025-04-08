class User < ApplicationRecord
  enum role: { admin: 0, sprint_admin: 1, task_admin: 2, user: 3 }
  devise :database_authenticatable, :registerable, :trackable, :confirmable,
         :recoverable, :rememberable, :validatable, :lockable
  has_many :tasks, foreign_key: :assignee_id
  has_many :tasks, foreign_key: :created_by_id
  has_many :projects, foreign_key: :created_by_id
  has_many :sprints, foreign_key: :created_by_id
  has_many :comments, foreign_key: :posted_by_id
  has_many :attachments, foreign_key: :uploaded_by_id

  validates :name, presence: true
  before_create :set_default_role

  def set_default_role
    self.role ||= :user
  end
end

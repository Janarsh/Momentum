class Project < ApplicationRecord
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"
  validates :created_by, presence: true
  has_many :sprints, dependent: :destroy
  has_many :tasks, through: :sprints
end

class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :posted_by, class_name: "User", foreign_key: "posted_by_id"
end

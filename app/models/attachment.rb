class Attachment < ApplicationRecord
  belongs_to :task
  belongs_to :uploaded_by, class_name: "User", foreign_key: "uploaded_by_id"
end

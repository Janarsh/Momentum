class Sprint < ApplicationRecord
  belongs_to :project
  belongs_to :created_by, class_name: "User"

  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date < start_date
      errors.add(:end_date, "end date must be after the start date")
    end
  end
end
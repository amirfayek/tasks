class Task < ApplicationRecord
  validates :title, presence: true

  belongs_to :user, optional: true
  belongs_to :assigned, class_name: 'User', foreign_key: 'assignee_id', optional: true

  scope :due_soon, -> { where('due_date <= ?', 7.days.from_now) }
end

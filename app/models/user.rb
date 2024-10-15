class User < ApplicationRecord
  has_secure_password

  has_many :tasks
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id'
end

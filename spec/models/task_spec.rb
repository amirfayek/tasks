require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:title) }
  it { should belong_to(:user).optional }
  it { should belong_to(:assigned).class_name('User').with_foreign_key('assignee_id').optional }
end

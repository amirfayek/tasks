require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should have_many(:tasks) }
  it { should have_many(:assigned_tasks).class_name("Task").with_foreign_key("assignee_id") }

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
end

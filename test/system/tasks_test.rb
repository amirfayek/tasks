require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  before do
    @user = FactoryBot.create(:user)
    sign_in_user(@user)
  end

  describe "visiting the index" do
    before do
      @task = FactoryBot.create(:task, user: @user)
    end

    it "lists the tasks created by a user" do
      visit tasks_url

      assert_selector "h1", text: "Tasks"
      assert_text @task.title
    end

    it "lists tasks assigned to a user" do
      assigned_task = FactoryBot.create(:task, :due_soon, assignee_id: @user.id)

      visit tasks_url
      click_on "Due Soon"

      assert_text assigned_task.title
      assert_no_text @task.title
    end
  end

  describe "creating a task" do
    it "creates a task" do
      visit tasks_url
      fill_in "Title", with: "Brush teeth"
      click_on "Save Task"

      assert_text "Brush teeth"
    end

    it "displays an error when creating a task without a title" do
      visit tasks_url
      click_on "Save Task"

      assert_text "Title can't be blank"
    end
  end

  def sign_in_user(user)
    visit new_session_url

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "Login"
  end
end

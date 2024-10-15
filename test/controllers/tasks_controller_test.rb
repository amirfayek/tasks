require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include SignInHelper

  setup do
    @user = FactoryBot.create(:user)
    sign_in_as(@user)
  end

  describe "GET #index" do
    it "returns a success response" do
      get tasks_url
      assert_response :success
    end

    it "redirects to the sign in page if not signed in" do
      sign_out
      get tasks_url
      assert_redirected_to new_session_path
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      task = FactoryBot.create(:task)
      get edit_task_url(task)
      assert_response :success
    end
  end

  describe "POST #create" do
    describe "with valid parameters" do
      it "creates a new Task" do
        assert_difference("Task.count") do
          post tasks_url, params: { task: { title: "Brush teeth" } }
        end

        assert_redirected_to tasks_path
        assert_equal "Task was successfully created.", flash[:notice]
      end
    end

    describe "with invalid parameters" do
      it "does not create a new Task" do
        assert_no_difference("Task.count") do
          post tasks_url, params: { task: { title: "" } }
        end

        assert_response :unprocessable_entity
      end
    end
  end

  describe "PATCH #update" do
    describe "with valid parameters" do
      it "updates the requested task" do
        task = FactoryBot.create(:task, title: "Old title")
        patch task_url(task), params: { task: { title: "New title" } }

        assert_redirected_to tasks_path
        assert_equal "New title", task.reload.title
      end
    end

    describe "with invalid parameters" do
      it "does not update the requested task" do
        task = FactoryBot.create(:task, title: "Old title")
        patch task_url(task), params: { task: { title: "" } }

        assert_response :unprocessable_entity
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      task = FactoryBot.create(:task)
      assert_difference("Task.count", -1) do
        delete task_url(task)
      end

      assert_redirected_to tasks_path
    end
  end
end

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  include SignInHelper

  describe "GET #new" do
    it "returns a success response" do
      get new_session_url
      assert_response :success
    end
  end

  describe "POST #create" do
    before do
      @user = FactoryBot.create(:user)
    end

    describe "with valid parameters" do
      it "creates a new session" do
        post session_url, params: { session: { email: @user.email, password: @user.password } }
        assert_redirected_to tasks_path
      end
    end

    describe "with invalid parameters" do
      it "does not create a new session" do
        post session_url, params: { session: { email: @user.email, password: "wrong_password" } }
        assert_response :unauthorized
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "destroys the current session" do
      post session_url, params: { session: { email: @user.email, password: @user.password } }
      assert @user.id, session[:user_id]
      delete session_url
      assert_redirected_to new_session_path
      assert_nil session[:user_id]
    end
  end
end

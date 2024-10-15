ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'factory_bot_rails'
require 'minitest/autorun'
require 'mocha/minitest'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  extend Minitest::Spec::DSL
end

module SignInHelper
  def sign_in_as(user)
    post session_url, params: { session: { email: user.email, password: user.password } }
  end

  def sign_out
    delete session_url
  end

  # Another way to handle signing in by stubbing the authenticate_user and current_user methods
  # def stub_sign_in
    # ApplicationController.any_instance.stubs(:authenticate_user).returns(true)
    # ApplicationController.any_instance.stubs(:current_user).returns(@user)
  # end
end

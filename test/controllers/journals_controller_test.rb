require 'test_helper'

class JournalsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  test "should get index" do
    @user = users(:one)
    login_as(@user, scope: :user)
    get journals_index_url, params: {token: @user.token}
    assert_response :success
  end
end

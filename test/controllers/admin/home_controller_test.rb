require 'test_helper'

class Admin::HomeControllerTest < ActionController::TestCase

  def setup
    @user = FactoryGirl.create(:admin_user)
    sign_in @user
  end

  test "routes are ok" do
    assert_routing '/admin', {controller: "admin/home", action: "index"}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_template "index", layout: "admin"
  end

  test "user must be signed in" do
    sign_out @user
    get :index
    assert_redirected_to new_user_session_path
  end

end

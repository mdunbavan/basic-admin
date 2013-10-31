require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  def setup
    @user = FactoryGirl.create(:admin_user)
    sign_in @user
  end

  test "routes are ok" do
    assert_routing({method: 'get', path: '/admin/users'}, { controller: "admin/users", action: "index" })
    assert_routing({method: 'get', path: '/admin/users/1'}, { controller: "admin/users", action: "show", id: "1" })
    assert_routing({method: 'get', path: '/admin/users/new'}, { controller: "admin/users", action: "new"})
    assert_routing({method: 'post', path: '/admin/users'}, { controller: "admin/users", action: "create" })
    assert_routing({method: 'get', path: '/admin/users/1/edit'}, { controller: "admin/users", action: "edit", id: "1" })
    assert_routing({method: 'patch', path: '/admin/users/1'}, { controller: "admin/users", action: "update", id: "1" })
    assert_routing({method: 'delete', path: '/admin/users/1'}, { controller: "admin/users", action: "destroy", id: "1" })
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should be admin" do
    @user.admin = false
    @user.save
    get :index
    assert_redirected_to :root
  end

end

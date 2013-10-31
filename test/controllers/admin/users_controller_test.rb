require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  def setup
    @user = FactoryGirl.create(:admin_user)
    @user2 = FactoryGirl.create(:user)
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

  test "can view user" do
    get :show, id: @user2.id
    assert_response :success
    assert_equal assigns(:user), @user2
  end

  test "can create user" do
    assert_difference "User.count" do
      post :create, user: {name: "New User", email: "new-example@example.com", password: "myvoiceismypassportauthenticteme", admin: "1"}
    end

    new_user = User.last
    assert_equal new_user.name, "New User"
    assert_equal new_user.email, "new-example@example.com"
    assert new_user.valid_password?("myvoiceismypassportauthenticteme")
    assert new_user.is_admin?
    assert_redirected_to admin_user_path(new_user)
  end

  test "creates password if not supplied" do
    assert_difference "User.count" do
      post :create, user: {name: "New Passwordless User", email: "new-passwordless-example@example.com"}
    end

    new_user = User.last
    assert_equal new_user.name, "New Passwordless User"
    assert_equal new_user.email, "new-passwordless-example@example.com"
    assert_redirected_to admin_user_path(new_user)
  end

  test "doesn't create user if parameters missing" do
    assert_no_difference "User.count" do
      post :create, user: {name: "New User", email: ""}
    end

    assert_not_nil assigns(:user)
    assert_template "new"
  end

  test "can update user" do
    assert_no_difference "User.count" do
      patch :update, id: @user2.id user: {name: "Updated User", email: "updated-example@example.com", admin: "1"}
    end

    updated_user = User.find(@user2.id)
    assert_equal updated_user.name, "Updated User"
    assert_equal updated_user.email, "updated-example@example.com"
    assert updated_user.is_admin?
    assert_redirected_to admin_user_path(updated_user)
  end

  test "doesn't update user if parameters missing" do
    assert_no_difference "User.count" do
      patch :update, id: @user2.id, user: {name: "Updated User Name", email: ""}
    end
    assert_not_nil assigns(:user)
    assert_template "edit"
  end

  test "can delete user" do
    assert_difference "User.count", -1 do
      delete :destroy, id: @user2.id
    end

    assert_redirected_to admin_users_path
  end

  test "should be admin" do
    @user.admin = false
    @user.save
    get :index
    assert_redirected_to :root
  end

end

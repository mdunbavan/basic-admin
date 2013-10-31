require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = FactoryGirl.build(:user)
    assert @user.save
  end

  test "user needs an email" do
    @user.email = ""
    assert ! @user.save
  end

  test "user needs a password" do
    @user.password = ""
    assert ! @user.save
  end

  test "user knows if it is an admin user" do
    assert ! @user.is_admin?

    @user.admin = true
    assert @user.is_admin?
  end

  test "user returns email instead of name if no name is set" do
    assert_equal @user.name, "My Lovely Name"

    @user.name = ""
    assert_equal @user.name, "example@example.com"
  end

end

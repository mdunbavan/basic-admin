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

  test "user needs a name" do
    @user.name = ""
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

end

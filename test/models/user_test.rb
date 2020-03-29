require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user with valid email and passowrd" do
    user = User.new(email: "test@email.com", password_digest: "testing...")
    assert user.valid?
  end

  test "User with invalid email" do
    user = User.new(email: "test", password_digest: "test")
    assert_not user.valid?
  end

  test "User with already taken email is invalid" do
    user1 = users(:one)
    user = User.new(email: user1.email, password_digest: "test")
    assert_not user.valid?
  end
end

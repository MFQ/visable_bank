require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "Account is valid " do
    account = Account.new(user_id: 1, balance: 20.00)
    assert_not_nil account.valid?
  end

  test "Account is invalid balance" do
    account = Account.new(user_id: 1, balance: -20.00)
    assert_not account.valid?
  end
end

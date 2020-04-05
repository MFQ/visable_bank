require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  test "Valid transaction" do
    transaction = Transaction.new(user_id: 1, transaction_kind: "debit", account_id: 1, amount: 12)
    assert_not_nil transaction.valid?
  end

  test " negative amount is not valid " do
    transaction =  Transaction.new(user_id: 1, transaction_kind: "debit", account_id: 1, amount: -12)
    assert_not transaction.valid?
  end

  test "without user_id not valid " do
    transaction =  Transaction.new(transaction_kind: "debit", account_id: 1, amount: 2)
    assert_not transaction.valid?
  end

  test  "without account_id not valid" do
    transaction =  Transaction.new(transaction_kind: "debit", user_id: 1, amount: 2)
    assert_not transaction.valid?
  end

  test "transaction_kind is invalid " do
    transaction = Transaction.new(user_id: 1, transaction_kind: "Debited", account_id: 1, amount: 12)
    assert_not transaction.valid?
  end

  test "valid transaction that will  update balance" do
    account = accounts(:one)
    transaction = Transaction.new(user_id: 1, transaction_kind: "credit", account_id: account.id, amount: 12)
    transaction.do_transaction
    assert_equal transaction.account.balance, 0.22e2
  end


end

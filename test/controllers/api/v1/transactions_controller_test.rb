require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @account = accounts(:one)
    @transaction = transactions(:one)
    @token = JsonWebToken.encode({ user_id: @user.id, email: @user.email })
    @headers = {
        "Authorization": JsonWebToken.encode({ user_id: @user.id, email: @user.email })
    }
  end

  test "should get index" do
    get api_v1_account_transactions_url(@account.id), as: :json, headers: @headers
    assert_response :success
  end

  test "should not able to process request" do
    get api_v1_account_transactions_url(@account.id), as: :json
    assert_response 401
  end

  test "should show transaction" do
    get api_v1_account_transaction_url(@account.id, @transaction.id), as: :json, headers: @headers
    assert_response :success
  end

  test "should create transactions" do
    post api_v1_account_transactions_url(@account.id), as: :json, headers: @headers, params: {
        transaction: {
            amount: 10.00,
            transaction_kind: "debit"
        }
    }
    assert_response :success
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete api_v1_transaction_url(@transaction), as: :json
    end

    assert_response 204
  end
end

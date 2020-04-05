require 'test_helper'

class Api::V1::AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @account = accounts(:one)
    @account.user_id = @user.id
    @token = JsonWebToken.encode({ user_id: @user.id, email: @user.email })
    @headers = {
        "Authorization": JsonWebToken.encode({ user_id: @user.id, email: @user.email })
    }
  end

  test "should not able to process request" do
    get api_v1_accounts_url, as: :json
    assert_response 401
  end

  test "should get index" do
    get api_v1_accounts_url, as: :json, headers: @headers
    assert_response :success
  end

  test "should show account" do
    get api_v1_account_url(@account), as: :json, headers: @headers
    assert_response :success
  end

  test "should create account" do
    post api_v1_accounts_url, as: :json, headers: @headers, params: {
        account: {
            balance: 20.00,
            user_id: @user.id
        }
    }
    assert_response :success
  end

  test "should destroy account" do
    assert_difference('Account.count', -1) do
      delete api_v1_account_url(@account), as: :json, headers: @headers
    end
    assert_response 204
  end

end

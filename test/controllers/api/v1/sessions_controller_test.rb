require 'test_helper'

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest

  test "register user" do
    email = "test#{Time.now.to_i}@gmail.com"
    post api_v1_register_url, params: { user: { email: email, password: '123456', password_confirmation: '123456' } }, as: :json
    assert_response :success
    json_response = JSON.parse self.response.body
    assert_equal email, json_response["email"]
  end

  test "login user" do
    post api_v1_login_url, params: { email: 'fazilqureshi@live.com', password: '123' }, as: :json
    assert_response :success
    json_response = JSON.parse self.response.body
    assert_not_nil json_response["token"]
  end
end

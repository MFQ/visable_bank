class Api::V1::SessionsController < ApplicationController

  def register
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      render json: { token: JsonWebToken.encode({ id: @user.id, email: @user.email }) }
    else
      render json: { message: "Unable to login" }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end

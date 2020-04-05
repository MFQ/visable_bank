class Api::V1::AccountsController < ApplicationController
  include Authenticable
  before_action :is_authentication
  before_action :set_account, only: [:show, :update, :destroy, :debit, :credit]

  # GET /accounts
  def index
    @accounts = @current_user.accounts
    render json: AccountSerializer.new(@accounts).serializable_hash
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = current_user.accounts.new(account_params)

    if @account.save
      render json: @account, status: :created
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = @current_user.accounts.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.require(:account).permit(:balance, :user_id)
    end
end

class Api::V1::TransactionsController < ApplicationController
  before_action :is_authentication, :set_account
  before_action :set_transaction, only: [:show, :update, :destroy]
  include Authenticable

  # GET /transactions
  def index
    @transactions = @account.transactions
    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    @transaction = @account.transactions.build(transaction_params)
    @transaction.user_id = @account.user_id
    @transaction.do_transaction
    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private

    def set_account
      @account = @current_user.accounts.find(params[:account_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = @account.transactions.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      params.require(:transaction).permit(:transaction_kind, :amount)
    end
end

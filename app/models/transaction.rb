class Transaction < ApplicationRecord
  CREDIT = "credit".freeze
  DEBIT = "debit".freeze
  transaction_kinds = [CREDIT, DEBIT].freeze
  belongs_to :user
  belongs_to :account, autosave: true
  validates :account_id, presence: true
  validates :user_id, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :transaction_kind, :inclusion => { :in => transaction_kinds, message: "invalid type" }

  def do_transaction
    ActiveRecord::Base.transaction do
      self.account.balance = self.transaction_kind == CREDIT ? self.account.balance + amount : self.account.balance - amount
    end
  end

end

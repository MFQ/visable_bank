class Account < ApplicationRecord
  Minimun = 0.freeze
  belongs_to :user
  has_many :transactions
  validates :user_id, presence: true
  validates :balance, numericality: {
      greater_than_or_equal_to: Minimun,
      message: "Minimum #{Minimun} balance has to be maintained, Invalid Transaction !!"
  }, presence: true

end

class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount, :transaction_kind
end

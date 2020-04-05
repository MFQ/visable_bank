class AccountSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :id, :balance
end

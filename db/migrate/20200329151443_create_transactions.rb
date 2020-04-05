class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_kind
      t.decimal :amount
      t.integer :user_id
      t.integer :account_id

      t.timestamps
    end
  end
end

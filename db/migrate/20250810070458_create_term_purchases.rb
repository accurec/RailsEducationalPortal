class CreateTermPurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :term_purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :term, null: false, foreign_key: true
      t.integer :payment_method
      t.timestamp :purchased_at

      t.timestamps
    end
  end
end

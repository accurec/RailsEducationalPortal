class MakeTermPurchasesPaymentMethodAndPurchasedAtNotNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :term_purchases, :payment_method, false
    change_column_null :term_purchases, :purchased_at, false
  end
end

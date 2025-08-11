class MakePaymentMethodAndPurchasedAtNotNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :course_purchases, :payment_method, false
    change_column_null :course_purchases, :purchased_at, false
  end
end

class CreateCoursePurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :course_purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :payment_method
      t.timestamp :purchased_at

      t.timestamps
    end
  end
end

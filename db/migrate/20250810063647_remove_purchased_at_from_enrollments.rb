class RemovePurchasedAtFromEnrollments < ActiveRecord::Migration[8.0]
  def change
    remove_column :enrollments, :purchased_at, :datetime
  end
end

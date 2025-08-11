class AddUniqueIndexToTermsOnNameAndSchoolId < ActiveRecord::Migration[8.0]
  def change
    add_index :terms, [:name, :school_id], unique: true
  end
end

class AddUniqueIndexToCoursesOnNameAndTermId < ActiveRecord::Migration[8.0]
  def change
    add_index :courses, [:name, :term_id], unique: true
  end
end

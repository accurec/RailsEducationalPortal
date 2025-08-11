class MakeEnrollmentsEnrolledAtNotNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :enrollments, :enrolled_at, false
  end
end

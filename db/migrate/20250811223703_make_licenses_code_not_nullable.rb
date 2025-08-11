class MakeLicensesCodeNotNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :licenses, :code, false
  end
end

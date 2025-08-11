class MakeTermsNameNotNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :terms, :name, false
  end
end

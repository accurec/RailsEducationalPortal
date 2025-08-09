class CreateLicenses < ActiveRecord::Migration[8.0]
  def change
    create_table :licenses do |t|
      t.string :code
      t.boolean :is_used, default: false

      t.timestamps
    end

    add_index :licenses, :code, unique: true  
  end
end

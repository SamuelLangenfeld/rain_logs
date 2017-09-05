class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.references :site, foreign_key: true

      t.timestamps
    end
  end
end

class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :latest_precip
      t.time :last_update
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

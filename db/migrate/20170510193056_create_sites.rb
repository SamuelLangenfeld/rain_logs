class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :day_precip
      t.string :week_precip
      t.references :user, foreign_key: true
      t.string :address
      t.string :station_id
      t.string :name
      t.string :latitude
      t.string :longitude
      t.timestamps
    end
  end
end

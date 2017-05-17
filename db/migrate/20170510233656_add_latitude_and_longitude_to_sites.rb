class AddLatitudeAndLongitudeToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :latitude, :string
    add_column :sites, :longitude, :string
  end
end

class AddLocationsToSite < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :address, :string
    add_column :sites, :geo_location, :hash
    add_column :sites, :station_id, :string
  end
end

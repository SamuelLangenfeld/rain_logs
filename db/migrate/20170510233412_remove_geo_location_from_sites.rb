class RemoveGeoLocationFromSites < ActiveRecord::Migration[5.0]
  def change
    remove_column :sites, :geo_location, :string
  end
end

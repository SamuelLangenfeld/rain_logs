class AddWeekPrecipToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :week_precip, :string
  end
end

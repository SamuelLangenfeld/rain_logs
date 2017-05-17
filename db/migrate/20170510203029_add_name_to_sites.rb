class AddNameToSites < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :name, :string
  end
end

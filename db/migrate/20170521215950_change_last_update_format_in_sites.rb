class ChangeLastUpdateFormatInSites < ActiveRecord::Migration[5.0]
  def up
    change_column :sites, :last_update, :datetime
  end

  def down
    change_column :sites, :last_update, :time
  end
end

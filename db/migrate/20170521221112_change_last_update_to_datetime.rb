class ChangeLastUpdateToDatetime < ActiveRecord::Migration[5.0]
  def up
    remove_column :sites, :last_update
    add_column :sites, :last_update, :datetime
  end

  def down
    remove_column :sites, :last_update
    add_column :sites, :last_update, :time
  end
end

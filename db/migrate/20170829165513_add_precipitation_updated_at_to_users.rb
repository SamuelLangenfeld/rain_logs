class AddPrecipitationUpdatedAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :precipitation_updated_at, :datetime
  end
end

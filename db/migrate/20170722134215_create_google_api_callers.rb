class CreateGoogleApiCallers < ActiveRecord::Migration[5.0]
  def change
    create_table :google_api_callers do |t|

      t.timestamps
    end
  end
end

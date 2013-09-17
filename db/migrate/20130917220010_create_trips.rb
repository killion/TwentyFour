class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.float :latitude
      t.float :longitude
      t.string :destination
      t.integer :user_id

      t.timestamps
    end
  end
end

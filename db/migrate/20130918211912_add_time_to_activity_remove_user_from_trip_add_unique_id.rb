class AddTimeToActivityRemoveUserFromTripAddUniqueId < ActiveRecord::Migration
  def change
    remove_column :trips, :user_id
    add_column :trips, :unique_id, :string, limit: 255
    add_column :activities, :time, :string, limit: 255
  end
end

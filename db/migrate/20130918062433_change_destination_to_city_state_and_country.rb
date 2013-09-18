class ChangeDestinationToCityStateAndCountry < ActiveRecord::Migration
  def change
    remove_column :trips, :destination
    add_column :trips, :city, :string, limit: 255
    add_column :trips, :state, :string, limit: 255
    add_column :trips, :country, :string, limit: 255
  end
end

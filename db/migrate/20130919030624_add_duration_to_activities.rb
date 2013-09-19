class AddDurationToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :duration, :string, limit: 255
  end
end

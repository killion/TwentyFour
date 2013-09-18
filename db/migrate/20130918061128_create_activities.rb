class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :trip_id
      t.string :title

      t.timestamps
    end
  end
end

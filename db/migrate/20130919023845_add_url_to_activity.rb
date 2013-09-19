class AddUrlToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :url, :string
  end
end

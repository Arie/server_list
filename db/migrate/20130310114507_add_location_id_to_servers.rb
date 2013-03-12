class AddLocationIdToServers < ActiveRecord::Migration
  def change
    add_column :servers, :location_id, :integer
  end
end

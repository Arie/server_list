class AddCacheColumnsToServers < ActiveRecord::Migration
  def change
    add_column :servers, :last_number_of_players, :integer
    add_column :servers, :last_max_players, :integer
    add_column :servers, :last_server_name, :string
  end
end

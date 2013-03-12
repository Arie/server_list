class CreateTableServerProperties < ActiveRecord::Migration
  def up
    create_table :server_properties do |t|
      t.integer :server_id
      t.integer :property_id
      t.timestamps
    end
  end

  def down
    drop_table :server_properties
  end
end

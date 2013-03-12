class CreateTableProperties < ActiveRecord::Migration
  def up
    create_table :properties do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :properties
  end
end

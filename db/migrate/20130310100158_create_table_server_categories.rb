class CreateTableServerCategories < ActiveRecord::Migration
  def up
    create_table :server_categories do |t|
      t.integer :server_id
      t.integer :category_id
      t.timestamps
    end
  end

  def down
    drop_table :server_categories
  end
end

class CreateServers < ActiveRecord::Migration
  def up
    create_table :servers do |t|
      t.string :name
      t.string :host
      t.string :port, :default => "27015"
    end
  end

  def down
    drop_table :servers
  end
end

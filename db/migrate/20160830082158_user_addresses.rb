class UserAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string   :line1
      t.string   :line2
      t.string   :city
      t.string   :state
      t.integer  :zip
      t.integer  :phone
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    add_index :addresses, [:user_id]
  end

  def self.down
    drop_table :addresses
  end
end

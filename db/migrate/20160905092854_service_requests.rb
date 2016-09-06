class ServiceRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.datetime :start_time
      t.string   :place
      t.integer  :duration
      t.text     :observations
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :requests
  end
end

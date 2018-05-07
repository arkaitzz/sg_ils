class AddEndTimeToRequest < ActiveRecord::Migration
  def self.up
    change_column :users, :administrator, :boolean, :default => false
    change_column :users, :applicant, :boolean, :default => true
    change_column :users, :interpreter, :boolean, :default => false

    add_column :requests, :end_time, :datetime
    change_column :requests, :confirmed, :boolean, :default => false
  end

  def self.down
    change_column :users, :administrator, :boolean, default: false
    change_column :users, :applicant, :boolean, default: true
    change_column :users, :interpreter, :boolean, default: false

    remove_column :requests, :end_time
    change_column :requests, :confirmed, :boolean, default: false
  end
end

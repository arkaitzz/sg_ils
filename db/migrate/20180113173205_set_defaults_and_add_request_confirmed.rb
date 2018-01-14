class SetDefaultsAndAddRequestConfirmed < ActiveRecord::Migration
  def self.up
    change_column :addresses, :line1, :string, :limit => nil
    change_column :addresses, :line2, :string, :limit => nil
    change_column :addresses, :city, :string, :limit => nil
    change_column :addresses, :state, :string, :limit => nil

    change_column :users, :remember_token, :string, :limit => nil
    change_column :users, :name, :string, :limit => nil
    change_column :users, :email_address, :string, :limit => nil
    change_column :users, :administrator, :boolean, :default => false
    change_column :users, :applicant, :boolean, :default => true
    change_column :users, :interpreter, :boolean, :default => false
    change_column :users, :state, :string, :limit => nil, :default => "inactive"

    add_column :requests, :confirmed, :boolean, :default => false
    change_column :requests, :place, :string, :limit => nil
  end

  def self.down
    change_column :addresses, :line1, :string, limit: 255
    change_column :addresses, :line2, :string, limit: 255
    change_column :addresses, :city, :string, limit: 255
    change_column :addresses, :state, :string, limit: 255

    change_column :users, :remember_token, :string, limit: 255
    change_column :users, :name, :string, limit: 255
    change_column :users, :email_address, :string, limit: 255
    change_column :users, :administrator, :boolean, default: false
    change_column :users, :applicant, :boolean, default: true
    change_column :users, :interpreter, :boolean, default: false
    change_column :users, :state, :string, limit: 255, default: "inactive"

    remove_column :requests, :confirmed
    change_column :requests, :place, :string, limit: 255
  end
end

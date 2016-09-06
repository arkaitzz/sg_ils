class RequestUserLink < ActiveRecord::Migration
  def self.up
    add_column :requests, :user_id, :integer
    add_column :requests, :interpreter_id, :integer

    add_index :requests, [:user_id]
    add_index :requests, [:interpreter_id]
  end

  def self.down
    remove_column :requests, :user_id
    remove_column :requests, :interpreter_id

    remove_index :requests, :name => :index_requests_on_user_id rescue ActiveRecord::StatementInvalid
    remove_index :requests, :name => :index_requests_on_interpreter_id rescue ActiveRecord::StatementInvalid
  end
end

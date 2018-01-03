# encoding: utf-8

# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'faker'

# Delete old data
User.delete_all

# Admin user
admin = User.create(:name => 'Administrator', :email_address => 'admin@zhik.info', :password => 'AdminPass', :administrator => true)


# lib/tasks/populate_with_basic_data.rake
#
# Rake task to populate production database with production data
# Run it with "rake db:populate_with_basic_data"

namespace :db do
  desc "Fill database with basic data"
  task :populate_with_basic_data => :environment do

    if !Rails.env.production?
      Request.destroy_all
      Address.destroy_all
      User.destroy_all

      # Create 1 admin user, 1 interpreter user and 1 applicant user
      User.create(
        :name => 'Usuario admin',
        :email_address => 'zhik-admin@euskal-gorrak.org',
        :state => 'active',
        :password => '12345678'
      ).become_administrator
      ils = User.create(
        :name => 'Usuario ILS',
        :email_address => 'zhik-ils@euskal-gorrak.org',
        :password => '12345678'
      )
      ils.become_interpreter
      ils.update_attribute(:state, 'active')
      User.create(
        :name => 'Usuario solicitante',
        :email_address => 'zhik-solicitante@euskal-gorrak.org',
        :password => '12345678'
      ).update_attribute(:state, 'active')

      puts 'Database populated, enjoy! :)'
    else
      puts 'Nothing to be done here as you are on a production environment, bye!'
    end

  end
end

# This is an auto-generated file: don't edit!
# You can add your own routes in the config/routes.rb file
# which will override the routes in this file.

Sgils::Application.routes.draw do


  # Resource routes for controller addresses
  resources :addresses

  # Owner routes for controller addresses
  resources :users, :as => :user, :only => [] do
    resources :addresses, :only => [] do
      get '/', :on => :new, :action => 'new_for_user'
      collection do
        get '/', :action => 'index_for_user'
        post '/', :action => 'create_for_user'
      end
    end
  end


  # Resource routes for controller users
  resources :users, :only => [:index, :edit, :show, :create, :update, :destroy] do
    collection do
      post 'signup', :action => 'do_signup'
      get 'signup'
    end
    member do
      get 'account'
      put 'activate', :action => 'do_activate'
      get 'activate'
      put 'reset_password', :action => 'do_reset_password'
      get 'reset_password'
    end
  end

  # User routes for controller users
  post 'login(.:format)' => 'users#login', :as => 'user_login_post'
  get 'login(.:format)' => 'users#login', :as => 'user_login'
  get 'logout(.:format)' => 'users#logout', :as => 'user_logout'
  get 'forgot_password(.:format)' => 'users#forgot_password', :as => 'user_forgot_password'
  post 'forgot_password(.:format)' => 'users#forgot_password', :as => 'user_forgot_password_post'


  # Resource routes for controller requests
  resources :requests

  # Owner routes for controller requests
  resources :users, :as => :user, :only => [] do
    resources :requests, :only => [] do
      get '/', :on => :new, :action => 'new_for_user'
      collection do
        get '/', :action => 'index_for_user'
        post '/', :action => 'create_for_user'
      end
    end
  end

  namespace :concerns do

  end

end

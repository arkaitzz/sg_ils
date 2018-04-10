ZHIK::Application.routes.draw do
  get ENV['RAILS_RELATIVE_URL_ROOT'] => 'front#index' if ENV['RAILS_RELATIVE_URL_ROOT']
  root :to => 'front#index'
  get 'users/:id/reset_password_from_email/:key' => 'users#reset_password', :as => 'reset_password_from_email'
  get 'users/:id/accept_invitation_from_email/:key' => 'users#accept_invitation', :as => 'accept_invitation_from_email'
  get 'users/:id/activate_from_email/:key' => 'users#activate', :as => 'activate_from_email'
  post 'search' => 'front#search', :as => 'site_search_post'
  get 'search' => 'front#search', :as => 'site_search'
  get 'menu' => 'users#main_menu', :as => 'main_menu'
  get 'role' => 'users#role_set', :as => 'users_role'
  get 'unassigned' => 'requests#unassigned', :as => 'unassigned_requests'

  # The proper way to create a request
  get 'create_request' => 'requests#pre_steps_creation', :as => 'new_request_creation'
  match 'step1/:request_id' => 'requests#step1', :as => 'request_step1', via: [:get, :post]
  match 'step2/:request_id' => 'requests#step2', :as => 'request_step2', via: [:get, :post]
  match 'step3/:request_id' => 'requests#step3', :as => 'request_step3', via: [:get, :post]
  post 'request_review/:request_id' => 'requests#review', :as => 'request_review'
  post 'confirm_review/:request_id' => 'requests#confirm', :as => 'request_confirm'

  # User requests
  get 'my_requests' => 'requests#my_requests', :as => 'my_requests'
end

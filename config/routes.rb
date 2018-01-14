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

  # The ordenated way to create a request
  get 'create_request' => 'requests#pre_steps_creation', :as => 'new_request_creation'
  get 'step1/:request_id' => 'requests#step1', :as => 'request_step1'
  get 'step2/:request_id' => 'requests#step2', :as => 'request_step2'
  get 'step3/:request_id' => 'requests#step3', :as => 'request_step3'
  get 'request_review/:request_id' => 'requests#review', :as => 'request_review'
  get 'request_confirm/:request_id' => 'requests#confirm', :as => 'request_confirm'

  # User requests
  get 'my_requests' => 'requests#my_requests', :as => 'my_requests'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

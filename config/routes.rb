Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get "/equipe" => 'welcome#equipe'
  get '/callback' => 'welcome#callback'
  get '/users' => 'users#index'
  patch '/users' => 'users#update', :as => 'update_user'
  delete '/users' => 'users#destroy', :as => 'delete_user'
  post '/users' => 'users#create', :as => 'create_user'
  get 'users/new' => 'users#new', :as => 'new_user'
  get 'order/categories' => 'categories#index'
  get 'order/categories/content' => 'categories#show', :as => 'show_category'
  patch 'order/categories' => 'categories#update', :as => 'update_category'
  get 'meal/new' => 'meals#new', :as => 'new_meal'
  post '/meals' => 'meals#create', :as => 'create_meal'
  delete '/meals' => 'meals#destroy', :as => 'delete_meal'
  post '/orders' => 'orders#create', :as => 'create_order'
  delete '/orders' => 'orders#destroy', :as => 'delete_order'
  get '/orders' => 'orders#show', :as => 'show_orders'
  get '/orders/all' => 'orders#index', :as => 'orders'
  patch '/orders/validate' => 'orders#validate', :as => 'validate_order'

  root 'welcome#index'

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

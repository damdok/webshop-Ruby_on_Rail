Rails.application.routes.draw do
  root to: 'statics#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'sessions/create'
  delete '/logout', to: 'sessions#destroy'

  get '/user', to: 'statics#user'
  patch '/user', to: 'statics#user'
  post '/user/balance', to: 'statics#balance'
  get '/user/balance/execute', to: 'statics#execute'
  get '/user/cart', to: 'statics#cart'
  get '/user/orders', to: 'order#previous'
  get '/user/products', to: 'order#products'

  get '/category/:name' => 'category#category'

  get '/product/:id' => 'category#product'
  get '/product/compare/select' => 'category#select'
  get '/product/compare/:first/:second' => 'category#compare'
  post '/product/rating' => 'category#rating'

  get '/popular' => 'statics#popular'

  post '/cart' => 'order#addtocart'
  delete '/cart/:id' => 'order#removefromcart'
  post '/cart/order' => 'order#order'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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

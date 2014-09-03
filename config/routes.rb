Devex::Application.routes.draw do
  root to: 'homes#index'
  
  get '/sign_up', to: 'users#new', as: 'sign_up'
  get '/sign_in', to: 'sessions#new', as: 'sign_in'
  get '/sign_out', to: 'sessions#destroy', as: 'sign_out'
  get '/request_token', to: 'users#request_token', as: 'ask_for_token'
  post '/send_token', to: 'users#send_password_token', as: 'send_token' 
  post '/resetpass', to: 'users#reset_password', as: 'reset_pass'
  resources :users do
  	member do
  		get 'newpass',to: 'users#new_password'
  	end
  end
  scope "/admins" do
    get '/', to: 'sessions#admin_new'
    get '/sign_in', to: 'sessions#admin_new', as: 'admin_sign_in'
    get '/sign_out', to: 'sessions#destroy', as: 'admin_sign_out'
    get '/request_token', to: 'admins#request_token', as: 'admin_ask_for_token'
    post '/send_token', to: 'admins#send_password_token', as: 'admin_send_token' 
    post '/resetpass', to: 'admins#reset_password', as: 'admin_reset_pass' 
    post '/sessions' ,to: 'sessions#admin_create', as: 'admin_sessions'
    resources :posts
  end
  resources :admins do
    member do
      get 'newpass',to: 'admins#new_password'
    end
  end
  resources :admins, only: [:show]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  #resources :posts, only: [:new, :create, :destroy, :edit, :update]
  #resources :admins, only: [:show]
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

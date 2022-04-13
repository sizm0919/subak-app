Rails.application.routes.draw do
  get 'rooms/show'
  resources :companies
  resources :product_prices
  resources :products
  resources :carts, only: [:show]
  resources :orders
  resources :creditcards
  resources :admin_products do
    collection do
      get 'search'
      get 'output'
      post 'import'
    end
  end
 
  root to: 'top#index'

  devise_for :admins, controllers: {
    sessions: "admins/sessions"
  }

  devise_for :accounts, controllers: {
    sessions:      "accounts/sessions",
    registrations: "accounts/registrations",
    passwords: "accounts/passwords"
  }

  post 'orders/order_position_delete' => 'orders#order_position_delete'
  
  post 'orders/show' ,to: 'orders#show'

  get 'creditcards/show'
  post 'creditcards/show'
  get 'creditcards', to: 'creditcards#show'
  post 'creditcards', to: 'creditcards#show'

  post 'carts/show' ,to: 'carts#show'
  post 'carts/buy' ,to: 'carts#buy'
  post 'carts/check' ,to: 'carts#check'

  get '/show' => 'carts#show'
  post '/add_item' => 'carts#add_item'
  post '/update_item' => 'carts#update_item'
  post '/delete_item' => 'carts#delete_item'

  get 'products/index'
  get 'products', to: 'products#index'

  get 'products/add'
  post 'products/add'

  get 'products/:id', to:'products#show'
  
  get 'products/edit/:id', to:'products#edit'
  patch 'products/:id/edit', to:'products#edit'
  
  get 'products/delete/:id', to:'products#delete'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'top/index'
  get 'top', to: 'top#index'
  post 'top/index'
  post 'top', to: 'top#index'
  
  get 'top/products'
  post 'top/products'
  get 'top/position'
  post 'top/position'
  get 'top/profile'
  post 'top/profile'
  get 'top/news'

  #admin
  get 'admins/index'
  get 'admins', to: 'admins#index'
  post 'admins/index'
  post 'admins', to: 'admins#index'
  get 'admins/help'

  #chat
  get 'rooms/index'
  
  resources :rooms, only: %i[show]


end

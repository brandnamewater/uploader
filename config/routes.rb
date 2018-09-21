Rails.application.routes.draw do
  devise_for :buyers
  resources :orders
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listings do
    resources :orders
  end


  get 'seller' => "listings#seller"
  get 'sales' => "orders#sales"
  post 'sales' => "orders#sales"
  get 'talent' => "listings#listings_page"

  get 'purchases' => "orders#purchases"

  root to: "listings#index"


end

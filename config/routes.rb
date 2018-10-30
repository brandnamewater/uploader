Rails.application.routes.draw do
  #resources :sales_uploads
  devise_for :buyers
  resources :orders
  devise_for :users, controllers: { confirmations: 'confirmations' }

  resources :users



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listings do
    resources :orders
end

  # resources :listings do
  #   resources :charges
  # end
  resources :orders do
    resource :charge, only: [:new, :create, :show]
  end

  get 'seller' => "listings#seller"

  resource :orders
  resolve('Charge') { [:charges] }


  # resource :charges
  # resolve('Charge') { [:orders] }

  resources :charges




  # resources :orders do
  #   resources :charges
  # end


  #new_order_sales_upload post '/orders/:order_ids(.:format) sales_uploads#new'
 get 'sales' => "orders#sales"
 post 'sales' => "orders#sales"

  #post 'sales' => "orders#sales"
  get 'talent' => "listings#listings_page"

  get 'purchases' => "orders#purchases"


  get 'dashboard' => "dashboard#dashboard"
  get 'yoyo' => "dashboard#tables"
  get 'charts' => "dashboard#charts"

get 'auth' => "users#index"

get 'stripe' => "listings#stripe"

# post 'charge' => "layouts#charges"
#
# post 'charge' => "listings#show"



  get 'car' => "listings#carousel"

  root to: "listings#index"


end

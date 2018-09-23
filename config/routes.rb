Rails.application.routes.draw do
  #resources :sales_uploads
  devise_for :buyers
  #resources :orders
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listings do
    resources :orders do
    resources :sales_uploads
  end
end
#  resources :orders do
#    resources :sales_uploads
#  end

  get 'seller' => "listings#seller"
  #get 'sales' => "orders#sales"
#  get 'sales' => "sales_uploads#sales"
#  post 'sales' => "sales_uploads#sales"

  get 'sales' => "orders#sales"
  post 'sales' => "orders#sales"

  #post 'sales' => "orders#sales"
  get 'talent' => "listings#listings_page"

  get 'purchases' => "orders#purchases"

  root to: "listings#index"


end

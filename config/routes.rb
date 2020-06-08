Rails.application.routes.draw do
  # get 'users/show'
  devise_for :admins
  # get 'products/index'
  # get 'products/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"
  resource :basket, only: %i(show)
  resource :charge, only: %i(create)
  resources :products, only: %i(show) do
    scope module: :products do
      resources :add_to_baskets, only: %i(create)
      resources :delete_in_baskets, only: %i(create)
    end
  end
  namespace :admins do
    root to: "dashboards#index"
    resources :products, only: %i(new create)
    resource :sales_record, only: %i(show)
  end
  namespace :users do
    resource :purchase_record, only: %i(show)
  end
  resources :users, only: %i(show)
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
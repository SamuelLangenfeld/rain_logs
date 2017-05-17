Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#home'
  resources :users, only: [:show]
  resources :sites
  post 'update_rain' => 'sites#update_rain'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

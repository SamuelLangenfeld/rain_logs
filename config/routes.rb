Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#home'
  resources :users, only: [:show]
  resource :users do
    post "immediate_update"
  end
  resources :sites
  post 'update_rain' => 'sites#update_rain'
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

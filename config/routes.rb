Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root to: 'pages#home'
  get 'users/profile', to: 'pages#user'
  get 'util/licenses', to: 'license_decoder#index'
  post 'util/licenses', to: 'license_decoder#upload'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users

  resources :stream
  resources :download

  root 'stream#index'
end

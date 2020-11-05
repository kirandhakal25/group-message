Rails.application.routes.draw do
  get 'messages/index'
  get 'messages/create'
  devise_for :users
  resources :messages
  root to: "messages#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

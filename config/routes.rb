Rails.application.routes.draw do
  get 'invitations/create'
  get 'invitations/update'
  get 'invitations/destroy'
  devise_for :users
  root 'events#index'

  resources :users, only: %i[show] 
  resources :events do
    resources :invitations
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

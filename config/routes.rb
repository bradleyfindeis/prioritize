Rails.application.routes.draw do
  root to: 'application#cookie'
  resources :users
  resources :lists
  resources :list_items do
    resources :votes, only: [:create, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  post '/signin', to: 'users#signin'
  post '/signup', to: 'users#signup'
  delete '/logout', to: 'sessions#destroy'
  post '/lists/:id/list_items', to: 'lists#add_list_item'
  get 'lists/:id/list_items', to: 'lists#list_items'
  post 'lists/:id/vote', to: 'lists#vote'
end

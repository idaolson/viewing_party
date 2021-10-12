Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# resources :welcome, only: :index
  root 'welcome#index'
  resources :users
  resources :dashboard, only: [:index]
  post '/login', to: 'users#login'
  get '/registration', to: 'users#new'
  post '/registration', to: 'users#create'
  get '/discover', to: 'movies#index'
  resources :friendships
end

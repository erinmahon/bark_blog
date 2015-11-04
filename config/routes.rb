Rails.application.routes.draw do

  get 'home/index'
  get '/' => "home#index"

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, except: :edit
  get '/profile/edit' => 'users#edit', as: 'edit_profile'
  resources :posts
  root 'users#new'

   post '/search' => 'users#search'
end


BasicAdmin::Application.routes.draw do

  devise_for :users

  namespace :admin do
      get "/" => "home#index"
      resources :users
  end

  root 'home#index'
end

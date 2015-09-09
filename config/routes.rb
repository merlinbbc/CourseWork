Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root "users#index"

  resources :users, :tasks
  post "markdown/preview"


end

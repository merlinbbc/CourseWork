Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  post "markdown/preview"
  root "users#index"

  resources :users, :tasks



end

Rails.application.routes.draw do
  resources :users, :tasks


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root "users#index"


end

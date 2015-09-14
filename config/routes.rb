Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  post "markdown/preview"
  root "users#index"
  resources :tasks do
    member do
      post :decision, :marks
    end
  end
  resources :users



end

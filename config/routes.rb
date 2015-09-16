Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  post "markdown/preview"
  root "users#index"

  get 'tags/:tag', to: 'tasks#index', as: :tag

  resources :tasks do
    member do
      post :decision, :marks
    end
  end
  resources :users
  get 'search', to: 'search#search'

end

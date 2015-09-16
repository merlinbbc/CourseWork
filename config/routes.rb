Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }



  resources :tasks do
    member do
      post :decision, :marks
    end
  end
  resources :users
  resources :comments
  post "markdown/preview"
  post 'comments/create', to: 'comments#create'
  root "users#index"
  get 'mytask', to: 'tasks#user_task'
end

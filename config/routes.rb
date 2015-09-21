Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  get 'tags/:tag', to: 'tasks#index', as: :tag


  resources :tasks do
    member do
      post :decision, :marks
    end
  end
  resources :users do
    member do
      get :generate_achievements_image
    end
  end
  resources :comments
  post "markdown/preview"
  post 'comments/create', to: 'comments#create'
  root "users#index"

  get 'mytask', to: 'tasks#user_task'
  get 'search', to: 'search#search'

end

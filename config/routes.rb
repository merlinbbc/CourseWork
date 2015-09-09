Rails.application.routes.draw do
<<<<<<< HEAD
=======


>>>>>>> 500e676dcc8164427ebbb940edd0c6c2897870fe

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root "users#index"
<<<<<<< HEAD
  resources :users, :tasks
  post "markdown/preview"
=======

  resources :users, :tasks
>>>>>>> 500e676dcc8164427ebbb940edd0c6c2897870fe
end

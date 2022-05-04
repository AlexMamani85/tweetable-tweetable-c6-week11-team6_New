Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "callbacks"}
  root "tweets#index"

  resources :tweets
  resources :users do
    resources :tweets
  end
end

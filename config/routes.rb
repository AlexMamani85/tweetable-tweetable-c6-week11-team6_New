Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "callbacks"}
  root "tweets#index"

  
  resources :tweets do
    # /tweets/:id/like
    get "like", on: :member
    # /tweets/:id/unlike
    get "unlike", on: :member
    # /tweets/:id/reply
    post "reply", on: :member
  end
  resources :users do
    resources :tweets 
  end
end

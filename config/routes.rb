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
  resources :users, only: %i[show edit] do
    # /user/:id/likes
    get "likes", on: :member
    # /user/:id/tweets
    get "tweets", on: :member
  end
end

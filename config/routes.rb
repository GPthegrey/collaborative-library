Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :books
  resources :loans
  resources :reviews, only: [:create]
  resources :events
  resources :bookclubs


  resources :chatrooms, only: [:index, :show, :create] do
    resources :messages, only: :create
  end

end

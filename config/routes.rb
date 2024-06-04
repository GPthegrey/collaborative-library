Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'pages/terminos_de_uso', to: "pages#terminos_de_uso", as: "terminos_de_uso"
  get 'users/:id', to: 'users#show', as: :user
  get 'profile', to: 'users#profile', as: :profile
  resources :books
  get 'mybooks', to: 'books#my_books', as: :mybooks
  resources :loans
  resources :reviews, only: [:create]
  resources :events
  resources :bookclubs

  resources :chatrooms, only: %i[index show create] do
    resources :messages, only: :create
  end
end

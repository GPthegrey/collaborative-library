Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'pages/terminos_de_uso', to: "pages#terminos_de_uso", as: "terminos_de_uso"
  get 'users/:id', to: 'users#show', as: :user
  get 'profile', to: 'users#profile', as: :profile

  resources :books do
    resources :loans, only: %i[new create]
  end

  resources :loans, except: %i[new create]
  patch 'loans/:id/accept_loan', to: 'loans#accept_loan', as: :accept_loan
  patch 'loans/:id/reject_loan', to: 'loans#reject_loan', as: :reject_loan
  patch 'loans/:id/return_loan', to: 'loans#return_loan', as: :return_loan

  get 'mybooks', to: 'books#my_books', as: :mybooks
  resources :reviews, only: [:create]
  resources :events
  resources :bookclubs

  resources :chatrooms, only: %i[index show create] do
    resources :messages, only: :create
  end
end

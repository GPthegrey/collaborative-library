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
  patch 'loans/:id/extension_request', to: 'loans#extension_request', as: :extension_request
  patch 'loans/:id/extension_accept', to: 'loans#extension_accept', as: :extension_accept
  patch 'loans/:id/extension_reject', to: 'loans#extension_reject', as: :extension_reject

  get 'mybooks', to: 'books#my_books', as: :mybooks
  get 'book_search', to: 'books#book_search', as: :book_search
  resources :reviews, only: [:create]
  resources :events
  resources :bookclubs

  resources :chatrooms, only: %i[index show create] do
    resources :messages, only: :create
  end
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

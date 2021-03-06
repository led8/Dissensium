Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  get 'join', to: 'pages#join', as: :join


  resources :users, only: [:show]
  resources :issues, only: [:new, :create, :show , :update], shallow: true do
    member do
      post 'start'
      get 'results'
      post 'final_result'
    end
    resources :solutions, only: [:new, :create]
    resources :votes, only: [:new, :create]
  end

  mount ActionCable.server => "/cable"
end

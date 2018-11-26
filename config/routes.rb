Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :users, only: [:show]
  resources :issues, only: [ :new, :create, :show , :update], shallow: true do
    resources :solutions, only: [ :new, :create] do
      resources :votes, only: [ :new, :create ]
    end
    member do
      get 'results'
    end
  end

  mount ActionCable.server => "/cable"
end

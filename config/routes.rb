Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :issues, only: [ :new, :create, :show ] do
    resources :solutions, only: [ :new, :create ] do
      resources :votes, only: [ :new, :create ]
    end
    member do
      get 'results', to: "issues#results"
    end
  end
end

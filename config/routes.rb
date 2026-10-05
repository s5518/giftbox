Rails.application.routes.draw do
  root "homes#top"
  get "/about", to: "homes#about"
  devise_for :admins
  devise_for :users

  scope module: :public do
    get "/mypage", to: "users#mypage", as: :mypage
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts do
      resource :bookmark, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :bookmarks, only: [:index]
  end

  namespace :admin do
    root "homes#top"
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :tags
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

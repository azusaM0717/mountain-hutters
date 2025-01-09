Rails.application.routes.draw do
  
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :huts, only: [:new, :index, :show, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :destroy] do
      resources :comments, only: [:index, :destroy]
    end
  end

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"
    resources :huts, only: [:index, :show]
    resources :users, only: [:show, :edit, :update]
    resources :reviews do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy] 
    end
    get "/mypage" => "users#show"
    get "/information/edit" => "users#edit"
    patch "/users/edit" => "users#update"
    get "users/unsubscribe" => "users#unsubscribe"
    patch "users/withdraw" => "users#withdraw"
    get "users/favorites" => "users#favorites"
    get "/search", to: 'searches#index', as: :search
  end
end

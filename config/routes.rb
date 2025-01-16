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
    resources :huts, only: [:new, :create, :index, :show, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :destroy] do
      resources :comments, only: [:index, :destroy] #レビューに対するコメント
    end
    resources :comments, only: [:index] #管理者側の全体コメント一覧用
  end

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"
    resources :huts, only: [:index, :show]
    resources :users, only: [:show, :edit, :update] do
      get "unsubscribe", on: :collection
      patch "withdraw", on: :collection
    end
    resources :reviews do
      resources :comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy] 
    end
    get "/mypage" => "users#show"
    get "/information/edit" => "users#edit"
    patch "/users/edit" => "users#update"
    get "/users/favorites" => "users#favorites"
    get "/search", to: 'searches#index', as: :search
  end
end

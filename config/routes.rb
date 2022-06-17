Rails.application.routes.draw do


  root to: "public/homes#top"
  get "/about" => "public/homes#about"

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'

  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :public, path: "" do

  # 以下、customers
  get 'customers/edit' => 'customers#edit', as: 'edit_mypage'
  patch 'customers' => 'customers#update'
  get 'customers/mypage' => 'customers#show', as: 'mypage'
  get 'customers/check' => 'customers#check', as: 'check'
  patch 'customers/withdraw' => 'customers#withdraw'
  # ここまで、customers


  end

  namespace :admin do
    resources :genres, only: [:index,:create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]

  end





end

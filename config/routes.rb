Rails.application.routes.draw do



  root to: "public/homes#top"
  get "/about" => "public/homes#about", as: "about"


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
  # 以下、addresses
    resources :addresses, only: [:index,:create, :edit, :update, :destroy]
  # 以下、items
    resources :items, only: [:index, :show]
    get '/search' => 'items#search', as: 'search'
  # 以下、genres
    resources :genres, only: [:show]
  # 以下、cart_items
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]
  # 以下、orders
    get 'orders/complete' => 'orders#complete', as: 'complete'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm' => 'orders#confirm', as: 'confirm'
  end




  namespace :admin do
  # 以下、genres
    resources :genres, only: [:index,:create, :edit, :update]
  # 以下、items
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  # 以下、customers
    resources :customers, only: [:index, :show, :edit, :update]
  # 以下、homes(注文履歴一覧)
    get '/' => 'homes#top'
  # 以下、orders（顧客別注文履歴一覧、注文履歴詳細、注文ステータス・着手状況の更新）
    resources :orders, only: [:index, :show, :update]
  # 以下、order_details（製作ステータスの更新）
    resources :order_details, only: [:update]
  end


end

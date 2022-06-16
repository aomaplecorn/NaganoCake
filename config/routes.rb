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

  namespace :public do

    resources :customers, only: [:show, :edit, :update, :check, :withdraw]
    # get 'customers/show'
    # get 'customers/edit'
    # get 'customers/update'
    # get 'customers/check'
    # get 'customers/withdraw'


  end


  namespace :admin do
    resources :genres, only: [:index,:create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]

  end





end

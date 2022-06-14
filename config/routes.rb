Rails.application.routes.draw do

  # root to: "public/homes#top"

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :genres, only: [:index,:create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]

  end





end

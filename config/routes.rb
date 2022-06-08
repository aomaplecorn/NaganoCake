Rails.application.routes.draw do
  
  
  
  
  devise_for :customers
  namespace :admin do
    devise_for :admins
  end


  # root to: "customers/homes#top"




end

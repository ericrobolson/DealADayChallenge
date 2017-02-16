Rails.application.routes.draw do
  resources :file_uploads
  resources :purchases
  resources :recent_purchases
   
  root 'application#index'
end

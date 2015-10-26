Rails.application.routes.draw do

  root 'cities#index'
  resources :cities, only: :index
end

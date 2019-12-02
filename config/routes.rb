Rails.application.routes.draw do
  get 'categories/index'
  namespace :api do
    namespace :v1 do
      resources :cards do
        get 'next', on: :member
      end
      resources :categories do
        resources :cards
      end
    end
  end

  get 'pages/home'
  get 'pages/about'

  root 'pages#home'
end

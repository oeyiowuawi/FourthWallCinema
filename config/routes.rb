Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :movies, only: [] do
      resources :show_times, only: [:update]
    end
    resources :sessions, only: [:create]
  end

  namespace :customer do 
    namespace :v1 do
      resources :movies, only: [:index, :show] do
        resources :reviews, only: [:create]
      end
    end
  end
end

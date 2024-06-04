Rails.application.routes.draw do
  devise_for :users
  root to: "ingredients#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
  resources :ingredients do
    collection do
      get :fridgy
    end
  end
  get "/set_meal_type", to: "ingredients#set_meal_type"
  get "/set_category", to: "ingredients#set_category"
  resources :recipes, only: [:index, :show, :create, :edit, :update] do
    member do
      get :favourite
    end
  end
  get "/list_favourites", to: "recipes#list_favourites"
end

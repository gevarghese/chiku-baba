Rails.application.routes.draw do
  #devise_for :users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  # Admin routes
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end
  
  # Regular user routes
  resources :users, only: [:show, :edit, :update]

  scope :pages, controller: :pages do
    get 'faq', as: :faq_page
    get 'terms', as: :terms_page
    get 'cookies', as: :cookies_page
    get 'privacy_policy', as: :privacy_policy_page
    get 'help_center', as: :help_center_page
  end
  get "dashboard/index"
  get "home/index"
  root "dashboard#index"
  get 'test_flash', to: 'home#test_flash'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

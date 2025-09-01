Rails.application.routes.draw do
  get "pages/faq"
  get "pages/terms"
  get "pages/cookies"
  get "pages/privacy_policy"
  get "pages/help_center"
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

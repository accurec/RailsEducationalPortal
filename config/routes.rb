Rails.application.routes.draw do
  namespace :student do
    get "dashboard", to: "dashboard#index"
    post "dashboard/:id/enroll_in_course", to: "dashboard#enroll_in_course", as: :enroll_in_course
    get "courses_to_purchase", to: "courses_to_purchase#index"
    post "courses_to_purchase/:id/purchase", to: "courses_to_purchase#purchase", as: :purchase_course
    get "terms_to_purchase", to: "terms_to_purchase#index"
  end

  namespace :admin do
    get "dashboard", to: "dashboard#index"
  end
  
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "home#index"
end

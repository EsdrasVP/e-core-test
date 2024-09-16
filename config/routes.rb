Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  resources :users, only: [ :index, :show ]
  resources :teams, only: [ :index, :show ]
  resources :roles, only: [ :create, :index ]
  resources :enrollments, only: [ :create, :index ]

  # Realistically, the following two endpoints should be PATCH instead, because normally in this kind of services,
  # there is a job that runs periodically to fetch new users/teams and update existing ones. To keep it simple for this
  # test, I just used the get requests so we can have users and teams imported quickly to the database
  get "users/import", to: "users#import"
  get "teams/import", to: "teams#import"

  get "enrollments/find", to: "enrollments#find"
end

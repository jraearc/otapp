Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admin_app_profile
  resources :admin_courses
  resources :admin_home
  resources :admin_settings
  resources :school_view
  resources :user_home
  resources :user_profile
  resources :user_settings

  root 'landing#index'
end

Rails.application.routes.draw do
  post 'signup', to: "signup#create"

  post 'sessions', to: "sessions#create"

  get 'sessions', to: "sessions#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Defines the landing page of the site
  root 'landing#index'

  # Defines admin pages
  get 'admin/', to: 'admin#admin_home'
  get 'admin/home', to: 'admin#admin_home', as: 'admin_home'
  get 'admin/settings', to: 'admin#admin_settings', as: 'admin_settings'
  post 'admin/settings/save', to: "admin#save"
  get 'admin/app_profile/:id(.:format)', to: 'admin#admin_app_profile', as: 'admin_app_profile'
  post 'admin/app_profile/editstatus', to: 'admin#edit_status'
  post 'admin/app_profile/deleteapp', to: 'admin#delete_application'
  get 'admin/courses', to: 'admin#admin_courses', as: 'admin_courses'
  post 'admin/courses/deletecourse', to: 'admin#delete_course'
  post 'admin/courses/addcourse', to: 'admin#add_course'

  # Defines student pages
  get 'student/', to: 'student#student_home'
  get 'student/home', to: 'student#student_home', as: 'student_home'
  get 'student/settings', to: 'student#student_settings', as: 'student_settings'
  post 'student/settings/save', to: "student#save"
  get 'student/profile', to: 'student#student_profile', as: 'student_profile'
  get 'student/profile/:id', to: 'student#student_profile_id', as: 'student_profile_id'
  post 'student/profile/addcourse', to: 'student#add_application'
  post 'student/profile/editcourse', to: 'student#edit_application'
  post 'student/profile/deletecourse', to: 'student#delete_application'
  get 'student/school_view/:id(.:format)', to: 'student#school_view', as: 'student_school_view'

end

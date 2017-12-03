Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Defines the landing page of the site
  root 'landing#index'

  # Defines admin pages
  get 'admin/', to: 'admin#admin_home'
  get 'admin/home', to: 'admin#admin_home'
  get 'admin/settings', to: 'admin#admin_settings'
  get 'admin/app_profile', to: 'admin#admin_app_profile'
  get 'admin/courses', to: 'admin#admin_courses'

  # Defines student pages
  get 'student/', to: 'student#student_home'
  get 'student/home', to: 'student#student_home'
  get 'student/settings', to: 'student#student_settings'
  get 'student/profile', to: 'student#student_profile'
  get 'student/school_view', to: 'student#school_view'

end

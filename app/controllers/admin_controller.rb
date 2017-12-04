class AdminController < ApplicationController
def admin_courses
	@all_courses = Course.order(:course_name)
end
end
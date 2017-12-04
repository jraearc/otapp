class AdminController < ApplicationController
def admin_courses
	@all_courses = Course.order(:course_name)
	@courses_offered = Offer.joins('join courses on offers.course_offered_id = courses.course_id').select('courses.course_name, courses.sector, courses.tuition_fee').where(school_id:1)
	#Palitan pa yung school id, testing lang yan haha
end
end
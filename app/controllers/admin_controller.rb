class AdminController < ApplicationController
def admin_courses
	@all_courses = Course.order(:course_name)
	@courses_offered = Offer.joins('join courses on offers.course_offered_id = courses.course_id').select('courses.course_name, courses.sector, courses.tuition_fee').where(school_id:1)
	#Palitan pa yung school id, testing lang yan haha
end
def admin_home
	@applicants = Apply.joins('join users on applies.student_userid = users.userid join applications on applies.ref_no = applications.ref_no join courses on applications.course_id = courses.course_id join schools on applies.school_id = schools.school_id').select('users.name, schools.sname').where("schools.sname='Academy Asia School of Technology and the Arts, Inc.'")
end
end
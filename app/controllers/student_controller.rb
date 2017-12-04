class StudentController < ApplicationController
def student_home
	@all_schools = School.order(:sname)
end
def student_profile
	@user_student = User.find(cookies[:userid])
	@stud_deets = Student.find(cookies[:userid])
	@apps = Apply.joins('join applications on applies.ref_no = applications.ref_no join courses on courses.course_id = applications.course_id join schools on applies.school_id = schools.school_id').select('applies.student_userid, schools.school_id, schools.sname, applies.is_received, courses.course_name').where(student_userid:cookies[:userid])
	#need pa ng "where" clause kasi lahat lang ng inaapplyan ng student yung lalabas
	# @apps = Apply.joins('join applications on applies.ref_no = applications.ref_no join courses on courses.course_id = applications.course_id join schools on applies.school_id = schools.school_id').select('applies.student_userid, schools.school_id, schools.sname, applies.is_received, courses.course_name').where(student_userid:1)
end
def school_view
	@school = School.find(params[:id]) 
	@courses = Offer.joins('join courses on offers.course_offered_id = courses.course_id join schools on offers.school_id = schools.school_id').select('courses.course_name,
		courses.duration, courses.sector,courses.tuition_fee').where(school_id:params[:id])
end

def student_settings

	@user_student = User.find(cookies[:userid])
	#change constant to session id

end
end
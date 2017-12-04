class AdminController < ApplicationController

def admin_courses
	@all_courses = Course.order(:course_name)
	@school = School.find(cookies[:userid]) #change constant to session id
	@courses_offered = Offer.joins('join courses on offers.course_offered_id = courses.course_id').select('courses.course_name, courses.sector, courses.tuition_fee').where(school_id:cookies[:userid])
end
def admin_home
	@temp = Manage.select('school_id').where(admin_userid: cookies[:userid]).first
	@school = School.find(@temp.school_id) #change constant to session id
	@school_admin = Admin.find(cookies[:userid]) #change constant to session id

	if params[:search]!=""
    	@applicants = Apply.joins('join users on applies.student_userid = users.userid join applications on applies.ref_no = applications.ref_no join courses on applications.course_id = courses.course_id join schools on applies.school_id = schools.school_id').select('users.userid,users.name, schools.sname').where("LOWER(users.name) LIKE ? ", "%#{params[:search]}%" )
  	else
    	@applicants = Apply.joins('join users on applies.student_userid = users.userid join applications on applies.ref_no = applications.ref_no join courses on applications.course_id = courses.course_id join schools on applies.school_id = schools.school_id').select('users.userid,users.name, schools.sname').where(school_id: cookies[:userid])
  	end
end
def admin_app_profile
	@applicant = User.find(params[:id]) #galing yung params sa pinasa from link ng admin_home
	@app_deets = Student.find(params[:id])
	@apps = Apply.joins('join applications on applies.ref_no = applications.ref_no join courses on courses.course_id = applications.course_id join schools on applies.school_id = schools.school_id').select('applies.is_received, courses.course_name').where(student_userid:params[:id])
	#need pa ng "where" clause kasi lahat lang ng inaapplyan ng student yung lalabas
end
def admin_settings
	@school = School.find(cookies[:userid]) #change constant to session id
	@school_admin = Admin.find(cookies[:userid]) #change constant to session id
end
end
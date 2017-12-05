class AdminController < ApplicationController
	before_action :check_if_admin

def admin_courses
	@temp = Manage.select('school_id').where(admin_userid:cookies[:userid]).first
	@all_courses = Course.order(:course_name)
	@school = School.find(@temp.school_id) #change constant to session id
	@courses_offered = Offer.joins('join courses on offers.course_offered_id = courses.course_id').select('courses.course_name, courses.sector, courses.tuition_fee').where(school_id:@temp.school_id)
end
def admin_home
	@temp = Manage.select('school_id').where(admin_userid: cookies[:userid]).first
	@school = School.find(@temp.school_id) #change constant to session id
	@school_admin = Admin.find(cookies[:userid]) #change constant to session id

	if params[:search]!="" && params[:radio]=="name"
    	@applicants = Apply.joins('join users on applies.student_userid = users.userid join applications on applies.ref_no = applications.ref_no join courses on applications.course_id = courses.course_id join schools on applies.school_id = schools.school_id').select('users.userid,users.name, schools.sname').select('users.userid,users.name, schools.sname').where("LOWER(users.name) LIKE ? ", "%#{params[:search]}%" )
    elsif params[:search]!="" && params[:radio]=="course"
    	@applicants = Apply.joins('join users on applies.student_userid=users.userid join applications on applies.ref_no=applications.ref_no join courses on applications.course_id = courses.course_id join schools on applies.school_id=schools.school_id').select('users.userid,users.name, schools.sname').where("LOWER(courses.course_name) LIKE ? and schools.school_id =?", "%#{params[:search]}%",cookies[:userid])
  	else
    	@applicants = Apply.joins('join users on applies.student_userid = users.userid join applications on applies.ref_no = applications.ref_no join courses on applications.course_id = courses.course_id join schools on applies.school_id = schools.school_id').select('users.userid,users.name, schools.sname').where(school_id: cookies[:userid])
  	end
end
def admin_app_profile
	@applicant = User.find(params[:id]) #galing yung params sa pinasa from link ng admin_home
	@app_deets = Student.find(params[:id])
	@apps = Apply.joins('join applications on applies.ref_no = applications.ref_no join courses on courses.course_id = applications.course_id join schools on applies.school_id = schools.school_id').select('applies.is_received, courses.course_name, applies.ref_no').where(student_userid:params[:id])
	#need pa ng "where" clause kasi lahat lang ng inaapplyan ng student yung lalabas
end
def admin_settings
	@temp = Manage.select('school_id').where(admin_userid:cookies[:userid]).first
	@school = School.find(@temp.school_id)
	@school_admin = Admin.find(cookies[:userid]) #change constant to session id
	@temp = Manage.find(cookies[:userid])
end
def save
	@temp = Manage.select('school_id').where(admin_userid:cookies[:userid]).first
	#@school = School.find(Manage.find(cookies[:userid]))
	@school = School.find(@temp.school_id)
	#change constant to session id
	@school.sname = params[:sname]
	@school.email = params[:e_mail]
	@school.address = params[:address]
	@school.phone = params[:phone]
	@school.save
	flash[:notice] = "Settings saved"
	redirect_to admin_settings_path
end
def edit_status
	begin
		@student = Student.joins('join applies on students.student_userid = applies.student_userid').where("applies.ref_no = ? ", Integer(params[:ref_no])).first
		@apply = Apply.where(ref_no: Integer(params[:ref_no])).update_all(is_received: params[:is_received])
		flash[:notice] = "Received status edited successfully."
		redirect_to admin_app_profile_path(@student.student_userid)
	rescue
		flash[:error] = "Error editing received status."
		redirect_to admin_app_profile_path(@student.student_userid)
	end
end

def delete_application
	begin
		@student = Student.joins('join applies on students.student_userid = applies.student_userid').where("applies.ref_no = ? ", Integer(params[:ref_no])).first
		@apply = Apply.where(ref_no: params[:ref_no]).delete_all
		@application = Application.where(ref_no: params[:ref_no]).delete_all
		flash[:notice] = "Application deleted."
		redirect_to admin_app_profile_path(@student.student_userid)
	rescue
		flash[:error] = "Error deleting application."
		redirect_to admin_app_profile_path(@student.student_userid)
	end
end

def check_if_admin
	if !cookies.key?(:userid)
		redirect_to root_url
	end
	@admin = Admin.where(admin_userid: cookies[:userid])
	if @admin.blank?
		@student = Student.where(student_userid: cookies[:userid])
		if @student.blank?
			redirect_to root_url
		else
			redirect_to student_home_path
		end
	end
end

end
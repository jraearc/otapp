class StudentController < ApplicationController
	before_action :check_if_student
def student_home
	@all_schools = School.order(:sname)
	if params[:search]!="" && params[:radio]=="school"
		@all_schools = School.select('school_id,sname, address').where("LOWER(sname) LIKE ? ", "%#{params[:search]}%" )
  	elsif params[:search]!="" && params[:radio]=="course"
  		@all_schools = Offer.joins('join schools ON offers.school_id = schools.school_id JOIN courses ON offers.course_offered_id = courses.course_id').select('schools.sname,schools.school_id,schools.address').where("LOWER(courses.course_name) LIKE ? ", "%#{params[:search]}%" )
  	elsif params[:search]=="" && params[:radio]==""
  		@all_schools = School.select('school_id,sname, address').where("LOWER(sname) LIKE ? ", "%#{params[:search]}%" )
  	else
    	@all_schools = School.order(:sname)
  	end
end
def student_profile
	@user_student = User.find(cookies[:userid])
	@stud_deets = Student.find(cookies[:userid])
	@apps = Apply.joins('join applications on applies.ref_no = applications.ref_no join courses on courses.course_id = applications.course_id join schools on applies.school_id = schools.school_id').select('applies.student_userid, schools.school_id, schools.sname, applies.ref_no, applies.is_received, courses.course_name').where(student_userid:cookies[:userid])
	@all_schools = School.order(:sname)
	@all_courses = Course.order(:course_name) 
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
def save
	@user_student = User.find(cookies[:userid])
	#change constant to session id
	@user_student.username = params[:username]
	@user_student.e_mail = params[:e_mail]
	@user_student.name = params[:name]
	@user_student.password = params[:password]
	@user_student.save
	flash[:notice] = "Settings saved"
	redirect_to student_settings_path
end
def add_application
	begin
		@course = Course.select('course_id').where(course_name: params[:course_name]).first
		@school = School.select('school_id').where(sname: params[:school]).first
		@application = Application.new(:course_id => @course.course_id)
		@application.save
		@apply = Apply.new(:student_userid => cookies[:userid], :school_id => @school.school_id, :ref_no => @application.ref_no, :is_received => 'No')
		@apply.save
		flash[:notice] = "Application added to database."
		redirect_to student_profile_path
	rescue
		flash[:error] = "Error adding application to database."
		redirect_to student_profile_path
	end
end

def edit_application
	begin
		@course = Course.select('course_id').where(course_name: params[:course_name]).first
		@application = Application.select('*').where(ref_no: params[:ref_no]).first
		@application.course_id = @course.course_id
		@application.save
		flash[:notice] = "Application edited successfully."
		redirect_to student_profile_path
	rescue
		flash[:error] = "Error editing application."
		redirect_to student_profile_path
	end
end

def delete_application
	begin
		@apply = Apply.where(ref_no: params[:reference_no]).delete_all
		@application = Application.where(ref_no: params[:reference_no]).delete_all
		flash[:notice] = "Application deleted."
		redirect_to student_profile_path
	rescue
		flash[:error] = "Error deleting application."
		redirect_to student_profile_path
	end
end

def check_if_student
	if !cookies.key?(:userid)
		redirect_to root_url
		return
	end
	@student = Student.where(student_userid: cookies[:userid])
	if @student.blank?
		@admin = Admin.where(admin_userid: cookies[:userid])
		if @admin.blank?
			redirect_to root_url
			return
		else
			redirect_to admin_home_path
			return
		end
	end
end

end
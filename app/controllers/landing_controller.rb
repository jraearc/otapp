class LandingController < ApplicationController
	before_action :check_if_logged_in
	def index
		@all_schools = School.order(:sname)
	end

	def check_if_logged_in
		if !cookies.key?(:userid)
			return
		end
		@student = Student.where(student_userid: cookies[:userid])
		if @student.blank?
			@admin = Admin.where(admin_userid: cookies[:userid])
			if @admin.blank?
				return
			else
				redirect_to admin_home_path
			end
		else
			redirect_to student_home_path
		end
	end
end
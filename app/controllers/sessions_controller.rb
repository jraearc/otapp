class SessionsController < ApplicationController
	def new
		redirect_to root_url
	end

	def create
		@user = User.find_by("LOWER(e_mail) = ?", params[:e_mail].downcase)

	if @user.present? && @user.authenticate(params[:password])
	  	cookies.permanent.signed[:username] = @user.username
	  	cookies[:userid] = @user.userid
	  	@searchuser_s = Student.where(student_userid: @user.userid)
	  	@searchuser_a = Admin.where(admin_userid: @user.userid)
	  	if !@searchuser_s.blank?
		 	redirect_to student_home_path
		elsif !@searchuser_a.blank?
			redirect_to admin_home_path
		end
	else
		render :new
	end
	end

	def destroy
		cookies.delete(:username)
		redirect_to root_url
	end

end

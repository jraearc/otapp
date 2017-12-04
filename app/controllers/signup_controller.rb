class SignupController < ApplicationController

  def create
    @user = User.new(username: params[:username], name: params[:name], e_mail: params[:e_mail], password: params[:password])
    if params[:type].eql? "Admin"
    	@admin = Admin.new(admin_userid: @user.userid, school_pos: params[:position])
    elsif params[:type].eql? "Student"
    	@student = Student.new(student_userid: @user.userid, birthdate: params[:birthdate], address: params[:address], civil_status: params[:civil_status])
    end
    if @user.save
	    cookies.signed[:username] = @user.username
	  	if params[:type].eql? "Student"
		 	redirect_to student_home_path
		elsif params[:type].eql? "Admin"
			redirect_to admin_home_path
		end
	else
      	flash[:error] = "Unable to create new account."
		redirect_to root_url
    end
  end

end

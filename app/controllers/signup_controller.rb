class SignupController < ApplicationController

  def create
  	begin
	    @user = User.new(:username => params[:username], :name => params[:name], :e_mail => params[:e_mail], :password => params[:password])
	    if @user.save
	    	if params[:type].eql? "Admin"
		    	@admin = Admin.new(:admin_userid => @user.userid, :school_pos => params[:school_pos])
		    	@school = School.find_by(sname: params[:school_name])
		    	@manage = Manage.new(:admin_userid => @admin.admin_userid, :school_id => @school.school_id)
		    elsif params[:type].eql? "Student"
		    	@student = Student.new(:student_userid => @user.userid, :birthdate => params[:birthdate], :address => params[:address], :civil_status => params[:civil_status])
		    end
		    cookies.signed[:username] = @user.username
		    cookies[:userid] = @user.userid
		  	if params[:type].eql? "Student"
		  		@student.save
			 	redirect_to student_home_path
			elsif params[:type].eql? "Admin"
				@admin.save
				@manage.save
				redirect_to admin_home_path
			end
		else
	      	flash[:error] = "Unable to create new account."
			redirect_to root_url
	    end
	rescue
		flash[:error] = "Unable to create new account."
		redirect_to root_url
	end
  end

end

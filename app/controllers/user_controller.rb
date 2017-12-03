class UserController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
	    if @user.save
	      log_in @user
	      flash[:success] = "Welcome to OTapp!"
	      redirect_to ''
	    else
	      redirect_to ''
	    end
	end

	def edit
	    @user = User.find(params[:id])
	end

	private

	    def user_params
	      params.require(:user).permit(:username, :e_mail, , :name, :password)
	    end
end
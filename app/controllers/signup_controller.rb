class SignupController < ApplicationController
  def new
  end

  def create
    @user = User.new(account_params)

    if @user.save
      cookies.signed[:username] = @users.username
      redirect_to root_url
    else
      render :new
    end
  end

end

class SessionsController < ApplicationController
  def new
  end

  #Sign-In Function
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
        sign_in user
        flash[:notice] = "Logged In!"
        redirect_back_or(root_url)
    else
        flash.now.alert = "Invalid email or password!"
        render 'new'
    end
  end
  
  #Sign-Out Function
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged Out!"
  end
end

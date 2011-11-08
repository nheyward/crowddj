module SessionsHelper
  
  def sign_in(user)
    session[:user_id] = user.id
  end
 

  def deny_access
    session[:return_to] = request.fullpath #Store the path that user was trying to get to 
    redirect_to log_in_path
  end
  
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
end

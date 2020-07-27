class SessionsController < ApplicationController
  def new
  end

  # def authenticate_with_credentials(email, password)
  #   @user = User.find_by_email(params[:email])
  #   if @user && @user.authenticate(params[:password])
  #     return @user
  #   else
  #     return nil
  #   end
  # end

  def create
   
    # If the user exists AND the password entered is correct.
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
    
      redirect_to '/login', notice: "Invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
   
    redirect_to '/login'
  end

end

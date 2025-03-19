class SessionsController < ApplicationController
    # The new method renders the login form. It contains no logic itself, and simply renders
    # the associated view (new.html.erb) that contains the login form HTML
    def new
    end
      # The create method handles the login process. It attempts to find a user in the
  # database based on the provided email, and, if found, checks the submitted password is
  # correct using Bcrypt's authenticate method and that the user's status is "Active". If
  # all of these are correct, the user's id, userFirstName, and isAdmin value are allocated to a
  # session object. Validated users are then redirected to a path that applies to them, i.e.
  # admin_path or userhome_path. If authentication fails, an error flash message is set and
  # the login form is re-rendered.
  def create
    if params[:emailAddress].present?
      user = User.find_by(emailAddress: params[:emailAddress].downcase)
      if user && user.authenticate(params[:password]) && user.accountStatus == "Active"
        session[:user_id] = user.id
        session[:userFirstName] = user.userFirstName
        session[:isAdmin] = user.isAdmin

        if session[:isAdmin]
          redirect_to admin_path, notice: "Logged in successfully!"
        else
          redirect_to userhome_path, notice: "Logged in successfully!"
        end
      else
        flash.now[:error] = "Invalid email or password. Please try again."
        render 'new'
      end
    end
  end

  # This destroy method handles the logout process. It clears all set parameters from the
  # session object, rendering it null, and then redirects user to the home page with an
  # appropriate message.
  def destroy
    reset_session
    @current_user = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
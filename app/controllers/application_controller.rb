# ApplicationController is the base controller for all other controllers in the application.
# It defines helper methods that manage user sessions and permissions across the app,
# ensuring consistent authentication and authorization behavior.

class ApplicationController < ActionController::Base
  # Make these methods accessible in both controllers and views for seamless access control logic.
  helper_method :current_user, :logged_in?, :is_administrator?

  # Retrieves the currently logged-in user from the session, if available.
  # Uses memoization (@current_user) to avoid unnecessary database lookups on multiple calls.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Checks if a user is currently logged in by verifying the presence of a valid user session.
  # Using `present?` makes the code more readable than using double negation (!!).
  def logged_in?
    current_user.present?
  end

  # Determines if the currently logged-in user has administrator privileges.
  # Uses safe navigation (&.) to avoid errors if current_user is nil.
  def is_administrator?
    current_user&.isAdmin
  end

  private

  # Ensures that only logged-in users can access certain parts of the application.
  # If a user is not logged in, they are redirected to the login page with an error message.
  def require_login
    unless logged_in?
      flash[:error] = "You are not permitted to access this resource"
      redirect_to login_path
    end
  end
end

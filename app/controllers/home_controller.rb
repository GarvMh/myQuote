# HomeController manages the display of quotes on the home page.
# It provides a personalized experience for logged-in users by showing both public and private quotes.
# Non-logged-in users can only see public quotes.

class HomeController < ApplicationController
  # The index action renders the homepage with a selection of quotes.
  # If the user is logged in, they see their private quotes and all public quotes.
  # If not logged in, only public quotes are displayed.
  def index
    if logged_in?
      # Fetch up to 5 quotes: all public quotes plus the user's private quotes.
      # Uses eager loading with .includes(:user) to minimize database queries.
      @quotes = Quote.includes(:user)
                     .where("isPrivate = ? OR user_id = ?", false, current_user.id)
                     .take(5)
    else
      # Fetch up to 5 public quotes for non-logged-in users.
      @quotes = Quote.includes(:user)
                     .where(isPrivate: false)
                     .take(5)
    end
  end

  # The uquotes action shows only the quotes belonging to the logged-in user,
  # including both public and private quotes. This provides a focused view of the user's own content.
  def uquotes
    @quotes = Quote.where(user_id: session[:user_id])
  end
end

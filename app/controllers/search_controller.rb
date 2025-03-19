# SearchController handles search functionality within the application.
# It allows users to search for quotes based on category names.
# The results are filtered based on the user's role and visibility settings of the quotes.

class SearchController < ApplicationController
  # GET /search
  # Renders the search results page based on the user's search query.
  # If a category query is provided, it searches for quotes matching the category name.
  # The search respects the visibility rules:
  # - Public quotes are always visible.
  # - Private quotes are visible only to the owner (if logged in).
  def index
    category_query = params[:category_query] # Retrieve the search term from the query parameters

    if category_query.present?
      # Fetch quotes matching the category name, ensuring that:
      # - Public quotes are included.
      # - The logged-in user can also see their private quotes.
      @quotes_match = Quote.joins(:categories)
                           .where("categories.categoryName LIKE ?", "%#{category_query}%")
                           .where("quotes.isPrivate = ? OR quotes.user_id = ?", false, current_user&.id)
                           .distinct # Avoid duplicate quotes in the search results
    end
  end
end

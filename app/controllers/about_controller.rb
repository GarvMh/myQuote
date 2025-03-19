# AboutController is responsible for displaying the 'About' page of the application.
# This page provides information about the founders of the project.
class AboutController < ApplicationController

  # The index action retrieves all founder records from the database
  # and makes them available to the view. This allows the 'About' page
  # to display information about each founder.
  def index
    @founders = Founder.all
  end

end

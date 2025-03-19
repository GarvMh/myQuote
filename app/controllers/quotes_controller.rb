# QuotesController manages the CRUD operations for quotes.
# It ensures access control based on user roles and handles associations 
# with authors and categories. Public and private quotes are also managed.

class QuotesController < ApplicationController
  # Ensure users are logged in for specific actions, except for index and show.
  before_action :require_login, except: %i[index show]
  
  # Set the quote object for show, edit, update, and destroy actions.
  before_action :set_quote, only: %i[show edit update destroy]
  
  # Ensure only the owner or admin can edit or delete a quote.
  before_action :authorize_user!, only: %i[edit update destroy]

  # GET /quotes or /quotes.json
  # Displays a list of quotes based on the user's role:
  # - Admins see all quotes (public and private).
  # - Logged-in users see their private quotes and all public quotes.
  # - Non-logged-in users only see public quotes.
  def index
    if current_user&.isAdmin
      @quotes = Quote.all
    elsif logged_in?
      @quotes = Quote.where("isPrivate = ? OR user_id = ?", false, current_user.id)
    else
      @quotes = Quote.where(isPrivate: false)
    end
  end

  # GET /quotes/1 or /quotes/1.json
  # Displays the details of a specific quote, along with its:
  # - Owner (user)
  # - Associated categories
  # - Author information
  def show
    @user = @quote.user
    @categories = @quote.categories
    @author = @quote.author
  end

  # GET /quotes/new
  # Initializes a new quote object, including nested author and category fields.
  def new
    @quote = Quote.new
    @quote.build_author # Build nested author fields for the form
    3.times { @quote.quote_categories.build } # Provide space for 3 categories by default
  end

  # GET /quotes/1/edit
  # Prepares the quote for editing and allows modification of up to 3 categories.
  def edit
    3.times { @quote.quote_categories.build }
  end

  # POST /quotes or /quotes.json
  # Creates a new quote and associates it with the current user.
  # On success, redirects to the quote's show page with a success message.
  # On failure, re-renders the form with error messages.
  def create
    @quote = Quote.new(quote_params)
    @quote.user = current_user

    respond_to do |format|
      if @quote.save
        flash[:notice] = "#{current_user.userFirstName} created a new quote: '#{@quote.quoteDescription}'"
        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
      else
        flash.now[:alert] = 'There were errors. Please fix them.'
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  # Updates an existing quote with the provided parameters.
  # On success, redirects to the quote's show page.
  # On failure, re-renders the form with error messages.
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
      else
        flash.now[:alert] = 'There were errors. Please fix them.'
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  # Deletes a quote if allowed by the user or admin.
  # On success, redirects to the index page with a success message.
  # On failure, displays an error message.
  def destroy
    if @quote.destroy
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: 'Quote was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        flash[:alert] = 'Could not delete the quote. Please try again.'
        format.html { redirect_to quotes_path }
        format.json { head :unprocessable_entity }
      end
    end
  end

  private

  # Fetches the quote record based on the ID parameter for specific actions.
  def set_quote
    @quote = Quote.find(params[:id])
  end

  # Ensures that only the owner of the quote or an admin can edit or delete it.
  # If unauthorized, redirects to the quotes index with an error message.
  def authorize_user!
    unless @quote.user == current_user || current_user&.isAdmin
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to quotes_path
    end
  end

  # Strong parameters to ensure only allowed data is processed.
  def quote_params
    params.require(:quote).permit(
      :quoteDescription, :comment, :publicationYear, :isPrivate, :user_id,
      author_attributes: [:authorFirstName, :authorSurname, :birthYear, :deathYear, :authorDescription],
      quote_categories_attributes: [:id, :category_id, :_destroy]
    )
  end
end

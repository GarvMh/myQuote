# QuoteCategoriesController manages the relationships between quotes and categories.
# It ensures that quotes can be assigned to multiple categories and handles the necessary
# operations for creating, updating, and deleting these associations.

class QuoteCategoriesController < ApplicationController
  # Sets the quote category object for actions that modify specific quote-category relationships.
  # This callback runs before the show, edit, update, and destroy actions.
  before_action :set_quote_category, only: %i[show edit update destroy]

  # GET /quote_categories or /quote_categories.json
  # Retrieves all quote-category relationships and makes them available to the view.
  def index
    @quote_categories = QuoteCategory.all
  end

  # GET /quote_categories/1 or /quote_categories/1.json
  # Displays the details of a specific quote-category relationship.
  def show
  end

  # GET /quote_categories/new
  # Prepares a new quote-category object for the 'new' view.
  # This is used when creating a new association between a quote and a category.
  def new
    @quote_category = QuoteCategory.new
  end

  # GET /quote_categories/1/edit
  # Fetches the quote-category object to be edited.
  def edit
  end

  # POST /quote_categories or /quote_categories.json
  # Creates a new quote-category association using the provided parameters.
  # If successful, redirects to the show page of the new association.
  # On failure, re-renders the new form with error messages.
  def create
    @quote_category = QuoteCategory.new(quote_category_params)

    respond_to do |format|
      if @quote_category.save
        format.html { redirect_to @quote_category, notice: "Quote-Category was successfully created." }
        format.json { render :show, status: :created, location: @quote_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quote_categories/1 or /quote_categories/1.json
  # Updates an existing quote-category relationship with the provided parameters.
  # On success, redirects to the show page of the updated association.
  # If the update fails, re-renders the edit form with error messages.
  def update
    respond_to do |format|
      if @quote_category.update(quote_category_params)
        format.html { redirect_to @quote_category, notice: "Quote-Category was successfully updated." }
        format.json { render :show, status: :ok, location: @quote_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quote_categories/1 or /quote_categories/1.json
  # Destroys a specific quote-category association and redirects to the index page.
  # JSON responses are handled by returning 'no content' status.
  def destroy
    @quote_category.destroy

    respond_to do |format|
      format.html { redirect_to quote_categories_path, status: :see_other, notice: "Quote-Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Fetches the quote-category record by ID for actions like show, edit, update, and destroy.
  def set_quote_category
    @quote_category = QuoteCategory.find(params[:id])
  end

  # Specifies which parameters are permitted when creating or updating a quote-category association.
  # This ensures only trusted attributes are used to modify the database.
  def quote_category_params
    params.require(:quote_category).permit(:quote_id, :category_id)
  end
end

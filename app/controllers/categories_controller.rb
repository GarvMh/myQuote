# CategoriesController manages the CRUD operations for the Category model.
# It allows users to create, view, update, and delete category records.
# JSON responses are also supported for API-based interactions.

class CategoriesController < ApplicationController
  # Sets the category object for specific actions to avoid code duplication.
  # This callback runs before show, edit, update, and destroy actions.
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories or /categories.json
  # Retrieves all categories from the database and makes them available to the view.
  def index
    @categories = Category.all
  end

  # GET /categories/1 or /categories/1.json
  # Displays the details of a specific category, identified by the ID parameter.
  def show
  end

  # GET /categories/new
  # Prepares a new, empty category object for the 'new' view.
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  # Fetches the category object to be edited.
  def edit
  end

  # POST /categories or /categories.json
  # Creates a new category record based on the submitted parameters.
  # If the record is successfully saved, it redirects to the category's show page.
  # If saving fails, it re-renders the new category form with error messages.
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  # Updates an existing category record with the provided parameters.
  # If the update is successful, it redirects to the category's show page.
  # On failure, it re-renders the edit form with error messages.
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  # Destroys the selected category record and redirects to the index page.
  # JSON responses are also handled by sending a 'no content' response.
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_path, status: :see_other, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Fetches the category record identified by the ID parameter from the database.
  # This is used by actions like show, edit, update, and destroy.
  def set_category
    @category = Category.find(params[:id])
  end

  # Specifies which parameters are permitted when creating or updating a category.
  # This ensures only the allowed attributes are saved to the database.
  def category_params
    params.require(:category).permit(:categoryName, :description)
  end
end

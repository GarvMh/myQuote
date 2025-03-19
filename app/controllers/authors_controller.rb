# AuthorsController manages the CRUD operations for the Author model.
# It allows users to create, view, update, and delete author records.
# JSON responses are also supported for API-based interactions.

class AuthorsController < ApplicationController
  # Sets the author object for specific actions to avoid code duplication.
  # This callback runs before show, edit, update, and destroy actions.
  before_action :set_author, only: %i[ show edit update destroy ]

  # GET /authors or /authors.json
  # Retrieves all authors from the database and makes them available to the view.
  def index
    @authors = Author.all
  end

  # GET /authors/1 or /authors/1.json
  # Displays the details of a specific author, identified by the ID parameter.
  def show
  end

  # GET /authors/new
  # Prepares a new, empty author object for the 'new' view.
  def new
    @authoр = Author.new
  end

  # GET /authors/1/edit
  # Fetches the author object to be edited.
  def edit
  end

  # POST /authors or /authors.json
  # Creates a new author record based on the submitted parameters.
  # If the record is successfully saved, it redirects to the author's show page.
  # If saving fails, it re-renders the new author form with error messages.
  def create
    author = Author.new(author_params)

    respond_to do |format|
      if author.save
        format.html { redirect_to author, notice: "Author was successfully created." }
        format.json { render :show, status: :created, location: author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  # Updates an existing author record with the provided parameters.
  # If the update is successful, it redirects to the author's show page.
  # On failure, it re-renders the edit form with error messages.
  def update
    respond_to do |format|
      if author.update(author_params)
        format.html { redirect_to author, notice: "Author was successfully updated." }
        format.json { render :show, status: :ok, location: author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1 or /authors/1.json
  # Destroys the selected author record and redirects to the index page.
  # JSON responses are also handled by sending a 'no content' response.
  def destroy
    author.destroy

    respond_to do |format|
      format.html { redirect_to authors_path, status: :see_other, notice: "Author was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Fetches the author record identified by the ID parameter from the database.
  # This is used by actions like show, edit, update, and destroy.
  def set_author
    @author = Author.find(params[:id])
  end

  # Specifies which parameters are permitted when creating or updating an author.
  # This ensures only the allowed attributes are saved to the database.
  def author_params
    params.require(:author).permit(:authorFirstName, :authorSurname, :authorDescription, :birthYear, :deathYear)
  end
end

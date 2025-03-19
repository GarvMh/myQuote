# UsersController manages user-related operations including sign-up, profile updates, 
# user listing (for admins), and account management. It ensures role-based access control 
# to protect sensitive actions like deleting users or accessing the user index.

class UsersController < ApplicationController
  # Ensure only logged-in users can access most actions, except for new and create (sign-up).
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_login, except: %i[new create]
  # Restrict the user index to admins only.
  before_action :authorize_admin, only: [:index]

  # GET /users/new
  # Renders the sign-up form for new users.
  def new
    @user = User.new
  end

  # GET /users or /users.json
  # Admin-only action to display all users.
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  # Displays the profile details of a specific user.
  def show
    @user = User.find(params[:id])
  end

  # GET /users/:id/edit
  # Renders the edit form, ensuring the user is either the owner or an admin.
  # Redirects to the home page with an alert if unauthorized.
  def edit
    unless @user == current_user || current_user&.isAdmin
      redirect_to root_path, alert: "Not authorized."
    end
  end

  # POST /users or /users.json
  # Handles user sign-up. If successful, redirects to the login page.
  # On failure, renders the sign-up form with appropriate error messages.
  def create
    @user = User.new(user_params)
    @user.accountStatus ||= 'Active'  # Assign 'Active' by default if not specified.

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: "Sign up successful. Please log in." }
      else
        handle_errors
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/:id or /users/:id.json
  # Updates the user profile. Ensures only the owner or an admin can perform the update.
  def update
    unless @user == current_user || current_user&.isAdmin
      redirect_to root_path, alert: "Not authorized." and return
    end

    respond_to do |format|
      if @user.update(update_user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
      else
        handle_errors
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:id or /users/:id.json
  # Deletes a user and their associated quotes. This action is restricted to admins only.
  # On success, redirects to the user index with a success message.
  def destroy
    unless current_user&.isAdmin
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path and return
    end

    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Fetches the user record by ID for actions like show, edit, update, and destroy.
  def set_user
    @user = User.find(params[:id])
  end

  # Ensures only admins can access specific actions like the user index.
  def authorize_admin
    unless current_user&.isAdmin
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end

  # Strong parameters for user creation, allowing only permitted attributes.
  def user_params
    params.require(:user).permit(
      :userFirstName, :userSurname, :emailAddress, 
      :password, :password_confirmation, :accountStatus
    )
  end

  # Strong parameters for updating a user, with additional fields for admins.
  def update_user_params
    if current_user.isAdmin
      params.require(:user).permit(
        :userFirstName, :userSurname, :emailAddress, 
        :password, :password_confirmation, :isAdmin, :accountStatus
      )
    else
      params.require(:user).permit(
        :userFirstName, :userSurname, :emailAddress, 
        :password, :password_confirmation
      )
    end
  end

  # Handles specific error messages for user creation and updating.
  def handle_errors
    if @user.errors[:emailAddress].any?
      flash[:alert] = "The email address you entered already exists. Please use a different email."
    elsif @user.errors[:password_confirmation].any?
      flash[:alert] = "The password confirmation doesn't match. Please try again."
    else
      flash[:alert] = "There were errors preventing the user from being saved."
    end
  end
end

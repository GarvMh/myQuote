Rails.application.routes.draw do
  # Resources for models with full RESTful actions where appropriate
  resources :quotes        # Routes for quotes (index, show, new, create, edit, update, destroy)
  resources :authors       # Routes for authors (index, show, new, create, edit, update, destroy)
  resources :categories    # Routes for categories (index, show, new, create, edit, update, destroy)
  resources :quote_categories # Routes for quote_categories (index, show, new, create, edit, update, destroy)

  # User routes with limited actions; index added for admins to manage users
  resources :users, only: [:index, :new, :create, :edit, :update, :show]

  # Session routes for login/logout
  get '/login', to: 'sessions#new'      # Route to display the login form
  post '/login', to: 'sessions#create'   # Route to handle the login submission
  delete '/logout', to: 'sessions#destroy' # Route to log the user out

  # Root route for the homepage
  root 'home#index' # Sets the root URL to the home controller's index action

  # Search route for finding quotes by category
  get 'search', to: 'search#index' # Route to handle search requests

  # Static pages
  get '/about', to: 'about#index' # Route for the About page

  # User and admin-specific dashboards
  get '/admin', to: 'home#aindex'  # Route for the admin dashboard
  get '/userhome', to: 'home#uindex' # Route for the user dashboard
  get '/your-quotes', to: 'home#uquotes'  # Route for displaying the user's quotes
end

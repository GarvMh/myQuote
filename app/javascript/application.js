// This file initializes key JavaScript libraries and ensures the Rails front-end 
// features (like unobtrusive JavaScript and Turbo) are ready to use.

// Import Rails UJS (Unobtrusive JavaScript) to handle AJAX, form submissions, 
// and other Rails-specific JavaScript behaviors.
import Rails from "@rails/ujs";

// Import Turbo from Hotwire to enable faster page loads by handling navigation 
// without full-page refreshes.
import "@hotwired/turbo-rails";

// Import all Stimulus controllers from the controllers directory.
// This makes them available throughout the application.
import "controllers";

// Initialize Rails UJS to enable Rails-specific JavaScript functionalities.
Rails.start();

// This file initializes the Stimulus.js application, which is used for adding client-side interactivity.
// Stimulus enhances the user experience by binding JavaScript behavior to HTML elements
// and provides a structured way to manage event handling in views.

import { Application } from "@hotwired/stimulus" // Import the Stimulus Application class.

// Start the Stimulus application, which scans the HTML for data-controller attributes
// and initializes the corresponding controllers.
const application = Application.start()

// Configure the development experience by enabling or disabling debug mode.
// Setting debug to false ensures production-like performance by minimizing console logs.
application.debug = false

// Expose the Stimulus application globally, allowing it to be accessed from the browser's console.
// This is useful for debugging and inspecting Stimulus controllers during development.
window.Stimulus = application

// Export the application to make it available for importing in other modules.
export { application }

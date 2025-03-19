// This is a basic Stimulus controller that demonstrates how to use Stimulus 
// to add interactivity to elements in your application.
// Stimulus automatically binds this controller to an HTML element with a matching data-controller attribute.

import { Controller } from "@hotwired/stimulus" // Import the base Controller class from Stimulus.

// Export a default class that extends the Stimulus Controller.
// This controller will automatically be connected to elements with the appropriate data-controller attribute.
export default class extends Controller {
  
  // The connect() method is called automatically when the controller is connected to the DOM.
  // Here, it updates the text content of the connected element to display "Hello World!".
  connect() {
    this.element.textContent = "Hello World!"
  }
}

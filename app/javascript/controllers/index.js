// This file serves as the entry point for importing and registering Stimulus controllers.
// It ensures that all controllers within the 'controllers' directory are loaded and registered
// automatically, streamlining the management of client-side behaviors.

// Import the Stimulus application instance to which controllers will be registered.
import { application } from "controllers/application"

// Import the helper function for eager loading controllers.
// 'eagerLoadControllersFrom' loads all controllers upfront, ensuring they are ready to use
// without waiting for user interactions or events.
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Eagerly load all controllers from the 'controllers' directory.
// This function scans for any file matching the pattern '*_controller.js' within the 'controllers' directory
// and registers them to the Stimulus application instance.
eagerLoadControllersFrom("controllers", application)

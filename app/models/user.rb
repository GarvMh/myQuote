# app/models/user.rb
# The User model represents individuals who interact with the application by creating quotes.
# It manages authentication with secure passwords and establishes relationships with quotes.

class User < ApplicationRecord
  # Enable secure password management using bcrypt.
  # This provides authentication methods like `authenticate`.
  has_secure_password

  # Association: A user can have many quotes.
  # When a user is deleted, all their associated quotes are also destroyed (cascading delete).
  has_many :quotes, dependent: :destroy

  # Validation: Ensures that the email address is present and unique (case-insensitive).
  # Displays a custom error message if the email already exists.
  validates :emailAddress, presence: true, uniqueness: { 
    case_sensitive: false, message: "already exists" 
  }

  # Callback: Before saving the user record, convert the email address to lowercase
  # to ensure consistency and prevent case-sensitive duplicates.
  before_save { self.emailAddress = emailAddress.downcase }
end

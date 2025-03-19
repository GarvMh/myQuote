# app/models/author.rb
# The Author model represents an individual who is credited with a quote.
# It establishes associations with quotes and enforces validations to ensure essential details are provided.

class Author < ApplicationRecord
  # Association: An author can have many quotes.
  # When an author is deleted, all their associated quotes are also destroyed (cascading delete).
  has_many :quotes, dependent: :destroy

  # Validations to ensure that required author details are present.
  validates :authorFirstName, presence: { message: "Author's First Name should exist" }
  # Allows the last name to be blank but adds validation if provided.
  validates :authorSurname, presence: { message: "Author's Last Name should exist" }, allow_blank: true
  # Allows the birth year to be blank, but requires it if present.
  validates :birthYear, presence: { message: "Author's Birth Year should exist" }, allow_blank: true
end

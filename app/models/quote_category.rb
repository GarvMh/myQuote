# app/models/quote_category.rb
# The QuoteCategory model acts as a join table between quotes and categories,
# establishing a many-to-many relationship between them. Each record in this model
# represents an association between a single quote and a single category.

class QuoteCategory < ApplicationRecord
  # Associations: This model links a quote to a category.
  # Each QuoteCategory record must belong to both a quote and a category.
  belongs_to :quote
  belongs_to :category

  # Validation: Ensures that a category is present for the association.
  # This validates the presence of the category object rather than the foreign key directly,
  # ensuring that the associated category exists in the database.
  validates :category, presence: true
end


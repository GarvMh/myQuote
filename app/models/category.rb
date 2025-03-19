# app/models/category.rb
# The Category model represents a classification or grouping for quotes.
# It establishes many-to-many relationships with quotes through the QuoteCategory join model.

class Category < ApplicationRecord
    # Association: A category can have many quote-category relationships.
    # When a category is deleted, all related quote-category associations are also destroyed.
    has_many :quote_categories, dependent: :destroy
  
    # Association: A category can be associated with many quotes through quote_categories.
    has_many :quotes, through: :quote_categories
  end
  
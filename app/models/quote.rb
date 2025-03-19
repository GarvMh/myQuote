# app/models/quote.rb
# The Quote model represents a quotation entered by users. It includes associations with 
# authors, categories, and users. Each quote can belong to multiple categories through 
# the QuoteCategory join model and can be marked as public or private.

class Quote < ApplicationRecord
  # Associations: A quote belongs to a user who created it and an author.
  # It can also belong to multiple categories through the QuoteCategory model.
  belongs_to :user
  belongs_to :author
  has_many :quote_categories, dependent: :destroy
  has_many :categories, through: :quote_categories

  # Nested attributes: Enables creation or updating of associated author and 
  # quote-category records directly from the quote form.
  accepts_nested_attributes_for :author
  # Allows destruction of quote-category associations and ignores blank category inputs.
  accepts_nested_attributes_for :quote_categories, allow_destroy: true, reject_if: :all_blank

  # Validation: Ensures that at least one category is selected for the quote.
  validates :quote_categories, presence: { message: "quote can't be blank" }

  # Scopes: Provide named query methods to filter quotes.
  # `public_quotes` returns only public quotes.
  scope :public_quotes, -> { where(isPrivate: false) }
  # `private_quotes` returns private quotes belonging to a specific user.
  scope :private_quotes, ->(user_id) { where(user_id: user_id, isPrivate: true) }
end

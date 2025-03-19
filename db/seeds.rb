# db/seeds.rb
# This file is used to seed the database with initial data for development and testing.

# Clear existing data
User.delete_all
# Create initial users
User.create!(userFirstName: "John", userSurname: "Jones", emailAddress: "admin@myquotes.com", password: "admin123", password_confirmation: "admin123", isAdmin: true, accountStatus: "Active") # Admin user
User.create!(userFirstName: "Vince", userSurname: "Brown", emailAddress: "vinceb@myemail.com", password: "vince123", password_confirmation: "vince123", isAdmin: false, accountStatus: "Active")
User.create!(userFirstName: "John", userSurname: "Smith", emailAddress: "jsmith@email.com", password: "jsmith123", password_confirmation: "jsmith123", isAdmin: false, accountStatus: "Active")
User.create!(userFirstName: "John", userSurname: "Doe", emailAddress: "johndoe@email.com", password: "jdoe123", password_confirmation: "jdoe123", isAdmin: false, accountStatus: "Active")
User.create!(userFirstName: "Jane", userSurname: "Doe", emailAddress: "janedoe@email.com", password: "janed456", password_confirmation: "janed456", isAdmin: false, accountStatus: "Suspended")
User.create!(userFirstName: "Bob", userSurname: "Smith", emailAddress: "bobsmith@email.com", password: "bsmith789", password_confirmation: "bsmith789", isAdmin: false, accountStatus: "Active")
User.create!(userFirstName: "Alice", userSurname: "Johnson", emailAddress: "alicejohnson@email.com", password: "johno432", password_confirmation: "johno432", isAdmin: false, accountStatus: "Active")
User.create!(userFirstName: "Sarah", userSurname: "Lee", emailAddress: "sarahlee@email.com", password: "slee123", password_confirmation: "slee123", isAdmin: false, accountStatus: "Active")
User.create!(userFirstName: "David", userSurname: "Brown", emailAddress: "davidbrown@email.com", password: "dbrown456", password_confirmation: "dbrown456", isAdmin: false, accountStatus: "Active")
User.create!(userFirstName: "Emily", userSurname: "Wilson", emailAddress: "emilywilson@email.com", password: "wilso789", password_confirmation: "wilso789", isAdmin: false, accountStatus: "Suspended")
User.create!(userFirstName: "Oliver", userSurname: "Taylor", emailAddress: "olivertaylor@email.com", password: "otay721", password_confirmation: "otay721", isAdmin: false, accountStatus: "Active")
User.create!(userFirstName: "Grace", userSurname: "Anderson", emailAddress: "graceanderson@email.com", password: "ando123", password_confirmation: "ando123", isAdmin: false, accountStatus: "Active")
User.create!(userFirstName: "Lucas", userSurname: "Scott", emailAddress: "lucasscott@email.com", password: "scotty456", password_confirmation: "scotty456", isAdmin: false, accountStatus: "Banned")
User.create!(userFirstName: "Larry", userSurname: "Bird", emailAddress: "lbird@email.com", password: "birdy983", password_confirmation: "birdy983", isAdmin: false, accountStatus: "Active")

# Create initial authors
Author.create!(authorFirstName: "Anne", authorSurname: "Frank", authorDescription: "Jewish diarist and Holocaust victim, known for 'The Diary of a Young Girl'.", birthYear: "1929", deathYear: "1945")
Author.create!(authorFirstName: "Albert", authorSurname: "Einstein", authorDescription: "Theoretical physicist who developed the theory of relativity.", birthYear: "1879", deathYear: "1955")
Author.create!(authorFirstName: "Warren", authorSurname: "Buffett", authorDescription: "American investor, business tycoon, and philanthropist, known as the 'Oracle of Omaha'.", birthYear: "1930", deathYear: nil)

# Create initial categories
Category.create!(categoryName: "Metaphysics")
Category.create!(categoryName: "Axiology")
Category.create!(categoryName: "Epistemology")
Category.create!(categoryName: "Logic")
Category.create!(categoryName: "Ethics")
Category.create!(categoryName: "Political Philosophy")
Category.create!(categoryName: "Aesthetics")

# Create initial quotes
Quote.create!(isPrivate: false, quoteDescription: "Laziness may appear attractive, but work gives satisfaction.", comment: "Anne Frank on hard work", publicationYear: "1944", user_id: 2, author_id: 1)
Quote.create!(isPrivate: false, quoteDescription: "Imagination is more important than knowledge.", publicationYear: "1929", user_id: 5, author_id: 2)
Quote.create!(isPrivate: false, quoteDescription: "The most important investment you can make is in yourself.", comment: "Warren Buffet on personal development", publicationYear: "2008", user_id: 3, author_id: 3)

# Create associations between quotes and categories
QuoteCategory.create!(quote_id: 1, category_id: 1)
QuoteCategory.create!(quote_id: 2, category_id: 3)
QuoteCategory.create!(quote_id: 3, category_id: 6)

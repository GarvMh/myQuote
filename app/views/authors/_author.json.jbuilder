json.extract! author, :id, :authorFirstName, :authorSurname, :authorDescription, :birthYear, :deathYear, :created_at, :updated_at
json.url author_url(author, format: :json)

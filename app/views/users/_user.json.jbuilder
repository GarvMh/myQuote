json.extract! user, :id, :userFirstName, :userSurname, :emailAddress, :digestPassword, :isAdmin, :accountStatus, :created_at, :updated_at
json.url user_url(user, format: :json)

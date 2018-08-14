json.extract! user, :id, :email, :password, :user_group, :created_at, :updated_at
json.url user_url(user, format: :json)

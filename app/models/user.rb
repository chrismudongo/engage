class User
  include Mongoid::Document
  field :email, type: String
  field :password, type: String
  field :user_group, type: String
end

class SurveyResponse
  include Mongoid::Document
  field :email, type: String
  field :user_group, type: String
  field :surveyID, type: String
  field :responses, type: Array
end

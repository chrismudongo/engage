class SurveyResponse
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :user_group, type: String
  field :surveyID, type: String
  field :newsID, type: String
  field :responses, type: Array



end

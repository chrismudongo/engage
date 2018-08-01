class Question
  include Mongoid::Document
  field :qtype, type: String
  field :tittle, type: String
  field :qline, type: String
  field :options, type: Array
  belongs_to :survey
  embedded_in :survey, :inverse_of => :questions
end

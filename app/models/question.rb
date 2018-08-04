class Question
  include Mongoid::Document

  embedded_in :survey, inverse_of: :questions
  
  field :qtype, type: String
  field :tittle, type: String
  field :qline, type: String



end

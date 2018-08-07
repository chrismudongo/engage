class Answer
  include Mongoid::Document
  field :content, type: String
  belongs_to :question, optional: true
  embedded_in :question, :inverse_of => :answers
end

class Question
  include Mongoid::Document

  field :content, type: String
  field :type, type: String
  has_many :answers
  belongs_to :survey, optional: true
  embedded_in :survey, :inverse_of => :questions
  embeds_many :answers
  accepts_nested_attributes_for :answers, :allow_destroy => true

end

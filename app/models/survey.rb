class Survey
  include Mongoid::Document


  field :name, type: String
  has_many :questions
  embeds_many :questions
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true


end

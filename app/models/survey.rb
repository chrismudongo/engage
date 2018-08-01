class Survey
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  #embeds_many :questions
  has_many :questions
  accepts_nested_attributes_for :questions

end

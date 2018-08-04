class Survey
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :group_id, type: String

  embeds_many :questions
  accepts_nested_attributes_for :questions, allow_destroy: true


end

class Complaint
  include Mongoid::Document

  # Fields
  field :title, type: String
  field :description, type: String

  # Relations
  belongs_to :user

  # Validations
  validates_presence_of :description
end

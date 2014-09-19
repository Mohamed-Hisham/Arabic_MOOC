class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :description, type: String

  # Relations
  belongs_to :question
  belongs_to :answerer , class_name: "Tutor" || "User"
  has_many :votes

  # Validations
  validates_presence_of :description
end

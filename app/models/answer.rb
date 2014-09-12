class Answer

  # Fields
  include Mongoid::Document
  include Mongo::Voteable

  field :description, type: String

  voteable self, :up => +1, :down => -1

  # Relations
  belongs_to :question
  belongs_to :answerer , class_name: "Tutor" || "User"

  # Validations
  validates_presence_of :description
end

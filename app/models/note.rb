class Note
  include Mongoid::Document

  # Field
  field :title, type: String
  field :description, type: String

  # Relations
  belongs_to :video
  has_one :author, class_name: "Tutor" || "User"

  validates_presence_of :description
end

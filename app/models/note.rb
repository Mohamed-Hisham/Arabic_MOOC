class Note
  include Mongoid::Document

  # Field
  field :title, type: String
  field :description, type: String
  field :author_type, type: String
  field :attachment

  mount_uploader :attachment, DocumentUploader

  # Relations
  belongs_to :video
  belongs_to :author, class_name: "Tutor" || "User"
  has_and_belongs_to_many :synmarks, dependent: :destroy

  validates_presence_of :description
end
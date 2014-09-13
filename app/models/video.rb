class Video
  include Mongoid::Document

  field :title,        type: String
  field :duration,     type: Integer
  field :video_file

  mount_uploader :video_file, VideoUploader

  # Relations
  belongs_to :section
  has_many :notes

  # Validations
  validates_presence_of :title
end

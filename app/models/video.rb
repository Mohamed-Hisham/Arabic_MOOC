class Video
  include Mongoid::Document

  field :title,        type: String
  field :duration,     type: Integer
  field :video_file
  field :viewed_by_guest, type: Boolean, default: false

  mount_uploader :video_file, VideoUploader

  # Relations
  belongs_to :section
  has_many :notes

  # Validations
  validates_presence_of :title

  # Functions
  def viewed_by_guest_status(param)
    self.update_attribute(:viewed_by_guest, param)
  end
end

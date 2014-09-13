class Section
  include Mongoid::Document

  after_find :calculate_section_length

  field :title,         type: String
  field :length,        type: Integer
  # Relations
  belongs_to :course
  has_many :videos

  validates_presence_of :title

  # Functions
  def calculate_section_length
    duration = 0
    self.videos.each do |video|
      duration += video.duration
    end
    self.update_attribute(:length, duration)
  end
end

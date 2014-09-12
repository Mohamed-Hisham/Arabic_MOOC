class Section
  include Mongoid::Document

  field :title,         type: String

  # Relations
  belongs_to :course
  has_many :videos

  validates_presence_of :title
end

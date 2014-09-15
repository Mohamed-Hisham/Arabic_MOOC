class Course
  include Mongoid::Document
  include Mongoid::Enum

  after_find :calculate_length

  # Fields
  field :title,         type: String
  field :description,   type: String
  field :tags,          type: Array
  field :length,        type: Integer
  field :avatar

  mount_uploader :avatar,  AvatarUploader
  rateable range: (1..5), raters: User
  enum :level, [:Beginner, :Mid, :Pro]

  # Relations
  has_and_belongs_to_many :users
  has_many :sections
  belongs_to :tutor
  belongs_to :category

  # Validations
  validates_presence_of :title
  validates_presence_of :description
  validates :title, uniqueness: true

  # Functions
  def calculate_length
    duration = 0
    self.sections.each do |section|
      duration += section.length
    end
    self.update_attribute(:length, duration)
  end
end

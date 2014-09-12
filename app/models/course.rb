class Course
  include Mongoid::Document
  include Mongoid::Enum

  # Fields
  field :title,         type: String
  field :description,   type: String
  field :tags,          type: Array
  field :length,        type: Time

  rateable range: (1..5), raters: User
  enum :level, [:beginner, :mid, :pro]

  # Relations
  has_and_belongs_to_many :users
  has_many :sections
  belongs_to :tutor
  belongs_to :category

  # Validations
  validates_presence_of :title
  validates_presence_of :description
  validates :title, uniqueness: true
end

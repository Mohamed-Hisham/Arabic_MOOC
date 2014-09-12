class Question
  include Mongoid::Document

  # Fields
  field :title, type: String
  field :description, type: String

  # Relations
  belongs_to :user
  has_many :answers

  validates_presence_of :title
end

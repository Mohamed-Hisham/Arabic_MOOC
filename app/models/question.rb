class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :title,            type: String
  field :description,      type: String
  field :to_delete,        type: Boolean, default: false

  # Relations
  belongs_to :user
  belongs_to :course
  has_many :answers
  has_many :votes

  validates_presence_of :title, :description

  # Functions
  def request_delete
    self.update_attributes!(to_delete: true)
  end
end
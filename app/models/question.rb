class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  after_find :votes_difference

  # Fields
  field :title,            type: String
  field :description,      type: String
  field :to_delete,        type: Boolean, default: false
  field :overall_votes,    type: Integer

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

  def votes_difference
    diff = self.votes.where(status: 1).count - self.votes.where(status: -1).count
    self.update_attributes!(overall_votes: diff)
  end
end
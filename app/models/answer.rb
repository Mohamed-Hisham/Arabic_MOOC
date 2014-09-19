class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  after_find :votes_difference

  # Fields
  field :description, type: String
  field :overall_votes,    type: Integer

  # Relations
  belongs_to :question
  belongs_to :answerer , class_name: "Tutor" || "User"
  has_many :votes

  # Validations
  validates_presence_of :description

  # Functions
  def votes_difference
    diff = self.votes.where(status: 1).count - self.votes.where(status: -1).count
    self.update_attributes!(overall_votes: diff)
  end
end

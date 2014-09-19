class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :status,           type: Integer
  field :votee_class,      type: String
  field :voter_class,      type: String

  # Relations
  belongs_to :voter, class_name: "User" || "Tutor"
  belongs_to :votee, class_name: "Question" || "Answer"

  # Functions
  def vote_up
    self.update_attributes!(status: 1)
  end

  def vote_down
    self.update_attributes!(status: -1)
  end
end

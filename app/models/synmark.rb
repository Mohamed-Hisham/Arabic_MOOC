class Synmark
  include Mongoid::Document

  # Fields
  field :start_time, type: Integer
  field :end_time,   type: Integer

  # Relations
  has_and_belongs_to_many :notes
end

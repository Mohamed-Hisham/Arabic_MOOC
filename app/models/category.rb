class Category

  include Mongoid::Document
  field :title, type: String

  validates_presence_of :title
  validates :title, uniqueness: true
end

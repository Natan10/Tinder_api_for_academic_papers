class Theme
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String 
  field :data, type: Time, default: -> {Time.now}
  field :tags, type: Array

  validates :title, presence: true

  belongs_to :teacher
end

class Teacher 
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String 
  field :latex_url, type: String

  validates :name, presence: true

  has_many :themes
end
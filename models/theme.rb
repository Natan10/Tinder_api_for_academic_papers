class Theme
  include Mongoid::Document

  field :title, type: String
  field :description, type: String 
  field :data, type: Date

  has_one :teacher
end
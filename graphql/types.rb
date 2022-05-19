require_relative "./base/base_query"

module Types
  class ThemeType < Types::BaseObject
    description "fields for themes"

    field :id, String, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :tags, [String], null: false
    field :data, String, null: true
  end

  class TeacherType < Types::BaseObject
    description "fields for teacher"

    field :id, String, null: false
    field :name, String,null: false
    field :email, String,null: false
    field :latex_url, String,null: true
    field :themes, [ThemeType], null: false
  end
end

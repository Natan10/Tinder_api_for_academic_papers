require_relative "./base/base_query"

module Types
  class TeacherType < Types::BaseObject
   
    description "field for teacher"

    field :id, String, null: false
    field :name, String,null: false
    field :email, String,null: false
    field :latex_url, String,null: true

  end
end

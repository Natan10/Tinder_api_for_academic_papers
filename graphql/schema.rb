require "graphql"

module Types
  class BaseObject < GraphQL::Schema::Object
  end
end

module Types
  class TeacherType < Types::BaseObject

    description "field for teacher"

    field :id, String, null: false
    field :name, String,null: false
    field :email, String,null: false
    field :latex_url, String,null: true
  end
end

class QueryType < GraphQL::Schema::Object
  description "root query"

  field :teachers, [Types::TeacherType], null: false 
  
  field :teacher,Types::TeacherType, null: false do
    argument :id, String, required: true
  end
    
  def teachers
    Teacher.all
  end

  def teacher(id:)
    Teacher.find(id)
  end
end

class TeacherSchema < GraphQL::Schema
  query(QueryType)
end
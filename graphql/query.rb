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
class QueryType < GraphQL::Schema::Object
  description "root query"

  field :teachers, [Types::TeacherType], null: false 
  
  field :teacher,Types::TeacherType, null: false do
    argument :id, String, required: true
  end

  field :themes, [Types::ThemeType], null: false
    
  def teachers
    Teacher.all
  end

  def teacher(id:)
    Teacher.find(id)
  end

  def themes
    Theme.all
  end
end
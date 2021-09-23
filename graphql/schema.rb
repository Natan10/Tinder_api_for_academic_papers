require "graphql"
require_relative "types"
# require_relative "mutations"


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


class CreateTeacherMutation < GraphQL::Schema::Mutation
  
  argument :name, String, required: true
  argument :email, String, required: true
  argument :latex_url, String, required: false

  field :success, Boolean, null: false
  field :teacher,Types::TeacherType, null: true

  def resolve(name:,email:,latex_url: nil)
    @teacher = Teacher.new({
      name: name,
      email: email ,
      latex_url: latex_url
      })
    if Teacher.where(name: name).one.nil?
      if @teacher.save!
        {success: true,teacher: @teacher}
      else 
        {success: false, teacher: nil}
      end
    else 
      {success: false, teacher: nil}
    end
  end

end

class DeleteTeacherMutation < GraphQL::Schema::Mutation
  argument :id, String, required: true

  field :success, Boolean, null: false

  def resolve(id:)
    test
    if Teacher.find(id).delete
      {success: true}
    else 
      {success: false}
    end
  end

  private 

  def test
    puts "testando deleteeeeeee"
  end
end

class MutationType < GraphQL::Schema::Object
  description "root mutation"

  field :createTeacher, mutation: CreateTeacherMutation
  field :deleteTeacher, mutation: DeleteTeacherMutation
end

class TeacherSchema < GraphQL::Schema
  query QueryType
  mutation MutationType
end
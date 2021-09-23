# require_relative "base_object"
# require "graphql"
# # require_relative "../repositories/teacher_repository"

# class Mutations::CreateTeacher < GraphQL::Schema::Mutation
  
#   argument :name, String, required: true
#   argument :email, String, required: true
#   argument :latex_url, String, required: false

#   field :success, Boolean, null: false

#   def resolve(name:,email:,latex_url:)
#     # @teacher = TeacherRepository.new(Teacher)
#     @teacher = Teacher.new(name,email,latex_url)
#     if @teacher.save!
#       {success: true}
#     else 
#       {success: false}
#     end
#     # @teacher.create(name,email,latex_url)
#   end

# end

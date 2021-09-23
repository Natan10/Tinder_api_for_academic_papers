require_relative "../base/base_mutation"


class Types::TeacherPutAttributes < Types::BaseInputObject
  description "Attributes for teacher update"
  argument :name, String, required: false
  argument :email, String, required: false
  argument :latex_url, String, required: false
end


module Mutation 
  class CreateTeacher < Types::BaseMutation
    
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

  class DeleteTeacher < Types::BaseMutation
    argument :id, String, required: true

    field :success, Boolean, null: false

    def resolve(id:)
      if Teacher.find(id).delete
        {success: true}
      else 
        {success: false}
      end
    end
  end

  class UpdateTeacher < Types::BaseMutation
    argument :id, String, required: true
    argument :attributes, Types::TeacherPutAttributes, required: true

    field :teacher,Types::TeacherType, null: true

    def resolve(id:,attributes:)
      @teacher = Teacher.find(id)
      attributes.each do |key,value| 
        @teacher.set("#{key}" => value)
      end
  
      {teacher: @teacher}
    end
  end
end

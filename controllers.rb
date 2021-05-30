require "sinatra/namespace"
require "sinatra/json"
require "json"
require "./models"
require "./serializers/teacher_serializer"

get "/" do 
  "Projeto teste usando Sinatra!"
end

namespace "/api/v1" do 

  before do
    content_type 'application/json'
  end

  helpers do
    def serializer_teacher(teacher, options={}) 
      TeacherSerializer.new(teacher).to_json
    end
  end
  
  namespace "/teachers" do 
    
    # GET /teachers/:id
    get "/:id" do
      teacher = Teacher.find(params[:id])
      serializer_teacher(teacher)
    rescue Mongoid::Errors::DocumentNotFound
      halt(404)
    end

    # GET /teachers 
    get "/" do 
      teachers = Teacher.all 
      teachers.map do |t|
        TeacherSerializer.new(t)
      end.to_json
    end

    # PATCH /teachers/id
    patch "/:id" do 
      new_attributes = JSON.parse(request.body.read)
      teacher = Teacher.find(params[:id])
      new_attributes.each do |key,value| 
        teacher.set("#{key}" => value)
      end

      serializer_teacher(teacher)
    rescue Mongoid::Errors::DocumentNotFound,JSON::ParserError, Mongoid::Errors::InvalidFind
      halt(404)
    end


    # DELETE /teachers/id
    delete "/:id" do 
      Teacher.find(params[:id]).delete
      halt(204)
    rescue Mongoid::Errors::DocumentNotFound
      halt(404)
    end

    # POST /teacher
    post "/" do
      params = JSON.parse(request.body.read)

      if Teacher.where(name: params["name"]).one.nil?
        teacher = Teacher.new(name: params["name"])
        teacher.save! if teacher.new_record?
        halt(201, serializer_teacher(teacher))
      end  
      halt(400, "Professor já existe".to_json)
    rescue Exception => e 
      halt(400, "Erro ao cadastrar professor!".to_json)
    end
  end

end
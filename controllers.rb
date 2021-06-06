require "sinatra/namespace"
require "json"
require "./models"
require "./serializers/teacher_serializer"
require "./repositories/teacher_repository"


before do
  content_type :json
end

get "/" do 
  halt(200,{message: "Projeto teste usando Sinatra!"}.to_json)
end

namespace "/api/v1" do 
  before do 
    @repository = TeacherRepository.new(Teacher)
  end

  helpers do
    def serializer_teacher(teacher, options={}) 
      TeacherSerializer.new(teacher).to_json
    end

    # Deprecado
    def json_body(request)
      JSON.parse(request.body.read) 
    end
  end
  
  namespace "/teachers" do 
    
    # GET /teachers/:id
    get "/:id" do
      teacher = @repository.find_by_id(params[:id])
      serializer_teacher(teacher)
    rescue Mongoid::Errors::DocumentNotFound
      halt(404)
    end

    # GET /teachers 
    get "/" do 
      teachers = @repository.all 
      teachers.map do |t|
        TeacherSerializer.new(t)
      end.to_json
    end

    # PATCH /teachers/id
    patch "/:id" do 

      new_attributes = params.except("id")

      if new_attributes.empty?
        halt(400, {message: "Parâmetros inválidos"}.to_json)
      end
      teacher = @repository.update_teacher(params[:id],new_attributes)
      serializer_teacher(teacher)
      
    rescue Mongoid::Errors::DocumentNotFound, Mongoid::Errors::InvalidFind => e
      halt(404, {message: "Professor não encontrado!"}.to_json)
    rescue Mongoid::Errors::UnknownAttribute => e
      halt(500, {message: "Parâmetros inválidos"}.to_json)
    end

    # DELETE /teachers/id
    delete "/:id" do 
      @repository.delete_teacher(params[:id])
      halt(204)
    rescue Mongoid::Errors::DocumentNotFound
      halt(404, {message: "Professor não encontrado!"}.to_json)
    end

    # POST /teachers/
    post "/" do
      teacher = @repository.create_teacher(params)
      halt(201, serializer_teacher(teacher))
    rescue Exception => e 
       halt(400, "Erro ao cadastrar professor!".to_json)
    end
  end

end
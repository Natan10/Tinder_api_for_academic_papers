require "sinatra/namespace"
require "json"
require "./models"
require "./serializers/teacher_serializer"
require "./repositories/teacher_repository"

get "/" do 
  "Projeto teste usando Sinatra!"
end

namespace "/api/v1" do 

  before do
    content_type 'application/json'
  end

  before do 
    @repository = TeacherRepository.new(Teacher)
  end

  helpers do
    def serializer_teacher(teacher, options={}) 
      TeacherSerializer.new(teacher).to_json
    end

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
      new_attributes = json_body(request)    
      teacher = @repository.update_teacher(params[:id],new_attributes)
      serializer_teacher(teacher)
    rescue Mongoid::Errors::DocumentNotFound,JSON::ParserError, Mongoid::Errors::InvalidFind
      halt(404)
    end


    # DELETE /teachers/id
    delete "/:id" do 
      @repository.delete_teacher(params[:id])
      halt(204)
    rescue Mongoid::Errors::DocumentNotFound
      halt(404)
    end

    # POST /teacher
    post "/" do
      params = json_body(request) 
      teacher = @repository.create_teacher(params)
      halt(201, serializer_teacher(teacher))
    rescue Exception => e 
       halt(400, "Erro ao cadastrar professor!".to_json)
    end
  end

end
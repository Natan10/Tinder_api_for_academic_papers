require "sinatra/namespace"
require "./models"
require "./serializers/teacher_serializer"
require "./serializers/theme_serializer"
require "./repositories/teacher_repository"
require "./repositories/theme_repository"



namespace "/api/v1" do 
  before do
    content_type :json
  end

  before do 
    @repository_theacher = TeacherRepository.new(Teacher)
    @repository_theme = ThemeRepository.new(Theme,@repository_theacher)
  end

  helpers do
    def serializer_teacher(teacher, options={}) 
      TeacherSerializer.new(teacher).to_json
    end

    def serializer_theme(theme,options={})
      ThemeSerializer.new(theme).to_json
    end

    # Deprecado
    def json_body(request)
      JSON.parse(request.body.read) 
    end
  end
  
  namespace "/teachers" do 
    
    # GET /teachers/:id
    get "/:id" do
      teacher = @repository_theacher.find_by_id(params[:id])
      serializer_teacher(teacher)
    rescue Mongoid::Errors::DocumentNotFound
      halt(404)
    end

    # GET /teachers 
    get "/" do
      teachers = @repository_theacher.all 
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
      teacher = @repository_theacher.update(params[:id],new_attributes)
      serializer_teacher(teacher)
      
    rescue Mongoid::Errors::DocumentNotFound, Mongoid::Errors::InvalidFind => e
      halt(404, {message: "Professor não encontrado!"}.to_json)
    rescue Mongoid::Errors::UnknownAttribute => e
      halt(500, {message: "Parâmetros inválidos"}.to_json)
    end

    # DELETE /teachers/id
    delete "/:id" do 
      @repository_theacher.delete(params[:id])
      halt(204)
    rescue Mongoid::Errors::DocumentNotFound
      halt(404, {message: "Professor não encontrado!"}.to_json)
    end

    # POST /teachers/
    post "/" do
      teacher = @repository_theacher.create(params)
      halt(201, serializer_teacher(teacher))
    rescue Exception => e 
      halt(400, "Erro ao cadastrar professor!".to_json)
    end
  end

  namespace "/themes" do 
    get "/" do 
      themes = @repository_theme.all
      themes.map do |theme|
        ThemeSerializer.new(theme)
      end.to_json
    end

    get "/:id" do
      theme = @repository_theme.find_by_id(params[:id])
      serializer_theme(theme)
    rescue Mongoid::Errors::DocumentNotFound
      halt(404)
    end

    post "/" do 
      theme = @repository_theme.create(params[:teacher_id],params.except("id")["theme"])
      halt(201,serializer_theme(theme))
    rescue Mongoid::Errors::DocumentNotFound 
      halt(404, "Professor não encontrado!".to_json)
    rescue  Mongoid::Errors::Validations
      halt(400, "Erro ao cadastrar tema!".to_json)
    end

    delete "/:id" do 
      @repository_theme.delete(params[:id])
      halt(204)
    rescue Mongoid::Errors::DocumentNotFound
      halt(404, {message: "Tema não encontrado!"}.to_json)
    end

    patch "/:id" do 
      new_attributes = params.except("id")

      if new_attributes.empty? 
        halt(400, {message: "Parâmetros inválidos"}.to_json)
      end
     
      theme = @repository_theme.update(params[:id],new_attributes)
      serializer_theme(theme)
    rescue Mongoid::Errors::DocumentNotFound
      halt(404,{message: "Tema não encontrado!"}.to_json)
    rescue Mongoid::Errors::UnknownAttribute
      halt(500, {message: "Parâmetros inválidos"}.to_json)
    end
  end
end
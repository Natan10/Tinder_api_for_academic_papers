require "sinatra/namespace"
require "sinatra/json"
require "json"
require "./models"

get "/" do 
  "Projeto teste usando Sinatra!"
end

namespace "/api/v1" do 
  before do
    content_type 'application/json'
  end
  
  namespace "/teachers" do 
    
    # GET /teachers/:id
    get "/:id" do
      teacher = Teacher.find(params[:id])
      halt(200,teacher.to_json(except: "_id"))
    rescue Mongoid::Errors::DocumentNotFound
      halt(404)
    end

    # GET /teachers 
    get "/" do 
      teachers = Teacher.all 
      halt(200,teachers.to_json)
    end

    # PATCH /teachers/id
    patch "/:id" do 
      new_attributes = JSON.parse(request.body.read)
      teacher = Teacher.find(params[:id])
      new_attributes.each do |key,value| 
        teacher.set("#{key}" => value)
      end

      halt(200,teacher.to_json)
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
        halt(201, teacher.to_json)
      end  
      halt(400, "Professor já existe".to_json)
    rescue Exception => e 
      halt(400, "Erro ao cadastrar professor!".to_json)
    end
  end

end
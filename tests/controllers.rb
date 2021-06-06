require_relative "test_helper"


describe "TeacherControllerTest" do 
  include Rack::Test::Methods

  API_URI = "/api/v1/teachers/"

  def app 
    Sinatra::Application
  end

  def json_parse(msg)
    JSON.parse(msg)
  end

  before :each do 
    Teacher.collection.drop
  end

  it "/" do 
    get "/"
    message = json_parse(last_response.body)["message"]
    assert_equal(last_response.status,200)
    assert_equal(message,"Projeto teste usando Sinatra!")
  end

  describe "/teachers" do
    it "return teachers" do  
      get "#{API_URI}" 
      response = json_parse(last_response.body)
      assert_equal(last_response.status,200)
    end

    it "return one teacher" do 
      teacher = create(:teacher)
       
      get "#{API_URI}#{teacher.id.to_s}" 
      response = json_parse(last_response.body)
      assert_equal(last_response.status,200)  
      assert_equal(response["id"],teacher.id.to_s)
    end

    describe "Post /create" do 
      
      it "Return 201" do 
        teacher = attributes_for(:teacher)

        post "#{API_URI}", teacher 
        response = json_parse(last_response.body) 
        assert_equal(last_response.status,201)
        assert_equal(response["nome"],teacher[:name])
      end

      describe "invalid params" do
        it "empty params" do 
          post "#{API_URI}", {}
          assert_equal(last_response.status,400)
        end

        it "without one param" do 
          teacher = {email: "teste@test.com"}
          post "#{API_URI}", teacher
          
          response = json_parse(last_response.body) 
          assert_equal(last_response.status,400)
          assert_equal(response,"Erro ao cadastrar professor!")
        end
      end
    end

    describe "Delete /:id" do 
      it "valid id" do 
        teacher = create(:teacher) 
        delete "#{API_URI}#{teacher.id}"
        assert_equal(last_response.status,204)
      end

      it "invalid id" do 
        delete "#{API_URI}10000"
        response = json_parse(last_response.body)
        assert_equal(last_response.status,404)
        assert_equal(response["message"],"Professor não encontrado!")
      end
    end

    describe "Patch /:id" do
     
      before do 
        @teacher = create(:teacher)
      end

      it "valid params" do 
        id = @teacher.id 
        new_attributes = {
          "name": "Teste1",
          "email": "teste@email.com"
        }
        
        patch "#{API_URI}#{id}", new_attributes
        
        response = json_parse(last_response.body)
        assert_equal(last_response.status,200)   
        assert_equal(response["nome"],new_attributes[:name])
      end

      it "invalid id" do 
        new_attributes = {
          "name": "Teste1",
          "email": "teste@email.com"
        }
        patch "#{API_URI}1000", new_attributes
        assert_equal(last_response.status,404)  
      end

      it "invalid params" do  
        patch "#{API_URI}#{@teacher.id}", {"teste": "teste.com"}
        assert_equal(last_response.status,500) 
      end

      it "empty params" do  
        patch "#{API_URI}#{@teacher.id}", {}
        response = json_parse(last_response.body)
        assert_equal(last_response.status,400)
        assert_equal(response["message"],"Parâmetros inválidos")
      end

    end
    
  end
end
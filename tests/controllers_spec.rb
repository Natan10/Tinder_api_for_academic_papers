require_relative "test_helper"


describe "ControllerTest" do 
  include Rack::Test::Methods

  API_URI_Teacher = "/api/v1/teachers/"
  API_URI_Themes = "/api/v1/themes/"

  def app 
    Sinatra::Application
  end

  def json_parse(msg)
    JSON.parse(msg)
  end

  before :each do 
    Teacher.collection.drop
    Theme.collection.drop
  end

  describe "/teachers" do
    it "return teachers" do  
      get "#{API_URI_Teacher}" 
      response = json_parse(last_response.body)
      assert_equal(last_response.status,200)
    end

    it "return one teacher" do 
      teacher = create(:teacher)
       
      get "#{API_URI_Teacher}#{teacher.id.to_s}" 
      response = json_parse(last_response.body)
      assert_equal(last_response.status,200)  
      assert_equal(response["id"],teacher.id.to_s)
    end

    describe "Post /create" do 
      
      it "Return 201" do 
        teacher = attributes_for(:teacher)

        post "#{API_URI_Teacher}", teacher 
        response = json_parse(last_response.body) 
        assert_equal(last_response.status,201)
        assert_equal(response["nome"],teacher[:name])
      end

      describe "invalid params" do
        it "empty params" do 
          post "#{API_URI_Teacher}", {}
          assert_equal(last_response.status,400)
        end

        it "without one param" do 
          teacher = {email: "teste@test.com"}
          post "#{API_URI_Teacher}", teacher
          
          response = json_parse(last_response.body) 
          assert_equal(last_response.status,400)
          assert_equal(response,"Erro ao cadastrar professor!")
        end
      end
    end

    describe "Delete /:id" do 
      it "valid id" do 
        teacher = create(:teacher) 
        delete "#{API_URI_Teacher}#{teacher.id}"
        assert_equal(last_response.status,204)
      end

      it "invalid id" do 
        delete "#{API_URI_Teacher}10000"
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
        
        patch "#{API_URI_Teacher}#{id}", new_attributes
        
        response = json_parse(last_response.body)
        assert_equal(last_response.status,200)   
        assert_equal(response["nome"],new_attributes[:name])
      end

      it "invalid id" do 
        new_attributes = {
          "name": "Teste1",
          "email": "teste@email.com"
        }
        patch "#{API_URI_Teacher}1000", new_attributes
        assert_equal(last_response.status,404)  
      end

      it "invalid params" do  
        patch "#{API_URI_Teacher}#{@teacher.id}", {"teste": "teste.com"}
        assert_equal(last_response.status,500) 
      end

      it "empty params" do  
        patch "#{API_URI_Teacher}#{@teacher.id}", {}
        response = json_parse(last_response.body)
        assert_equal(last_response.status,400)
        assert_equal(response["message"],"Parâmetros inválidos")
      end
    end   
  end

  describe "/themes" do
    it "return themes" do 
      themes = create_list(:theme,4)
      get "#{API_URI_Themes}"
      response = json_parse(last_response.body)
       
      assert_equal(last_response.status,200)
      assert_equal(response.count,4)
    end

    it  "return theme by id" do 
      themes = create_list(:theme,3)

      get "#{API_URI_Themes}/#{themes.first.id}"
      response = json_parse(last_response.body)
      
      assert_equal(last_response.status,200)
      assert_equal(response["title"],themes.first.title)
    end

    it "invalid theme id" do 
      get "#{API_URI_Themes}/1000"

      assert_equal(last_response.status,404)
    end


    describe "Post /" do
      let(:teacher) {create(:teacher)}

      it "return 201" do 
        theme = attributes_for(:theme)
      
        params = {
          teacher_id: teacher.id,
          theme: theme
        }
        post "#{API_URI_Themes}", params  
        response = json_parse(last_response.body) 
      
        assert_equal(last_response.status,201)
        assert_equal(response["title"],theme[:title])
      end

      it "empty teacher" do 
        theme = attributes_for(:theme)
        params = {
          teacher_id: "152368",
          theme: theme
        }
        post "#{API_URI_Themes}", params  
        assert_equal(last_response.status,404)
      end

      it "empty theme" do 
        theme = {}
       
        params = {
          teacher_id: teacher.id,
          theme: theme
        }
        post "#{API_URI_Themes}", params  
        assert_equal(last_response.status,400)
      end

      it "invalid theme" do 
        theme = {
          title: "Test1",
          tags: ["A","B"]
        }

        params = {
          teacher_id: teacher.id,
          theme: theme
        }
        post "#{API_URI_Themes}", params  
        assert_equal(last_response.status,400)
      end
    end

    describe "Delete /:id" do
      it "Return 204" do 
        theme = create(:theme)

        delete "#{API_URI_Themes}/#{theme.id}"
        assert_equal(last_response.status,204)
      end

      it "invalid theme" do 
        delete "#{API_URI_Themes}/1000"
        response = json_parse(last_response.body) 
        assert_equal(last_response.status,404)
        assert_equal(response["message"], "Tema não encontrado!")
      end
    end


    describe "Path /:id" do 

      let(:theme) { create(:theme) }

      it "valid params" do 
        id = theme.id 
        
        new_params = {
          title: "new title"
        }
      
        patch "#{API_URI_Themes}/#{id.to_s}", new_params
        response = json_parse(last_response.body) 
        
        assert_equal(last_response.status,200)
        assert_equal(response["title"],new_params[:title])

      end

      it "empty params" do 
        id = theme.id 
        patch "#{API_URI_Themes}/#{id}", {}
        assert_equal(last_response.status, 400)
      end

      it "invalid params" do 
        id = theme.id 
        new_params = {
          tempo: "new title"
        }
        patch "#{API_URI_Themes}/#{id}", new_params
        assert_equal(last_response.status, 500)
      end
    end
    
  end
  
end

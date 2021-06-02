require_relative "test_helper"


describe "TeacherControllerTest" do 
  include Rack::Test::Methods

  def app 
    Sinatra::Application
  end

  def json_parse(msg)
    JSON.parse(msg)
  end

  it "/" do 
    get "/"
    message = json_parse(last_response.body)["message"]
    assert_equal(last_response.status,200)
    assert_equal(message,"Projeto teste usando Sinatra!")
  end

  describe "/teachers" do
    it "return teachers" do 
      get "/api/v1/teachers/" 
      response = json_parse(last_response.body)
      assert_equal(last_response.status,200)
      assert_equal(response.size,1)
    end
  end
  
  
end
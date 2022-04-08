require 'app'  
require 'rack/test'

RSpec.describe 'app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "GET to /" do
    let(:response) { get '/' }
    it 'reponse returns hello world' do
      expect(response.body).to eq('Hello World')
    end

    it 'returns status 200 OK' do
      expect(response.status).to eq(200)
      expect(response).to be_ok
    end
  end
  describe "GET to /start-game/:player1_token" do

    context "GET human vs human game" do 
      let(:response){ get '/start-game/1'}
      

      it 'returns status 200 OK' do
        p 'request', response
        expect(response.status).to eq 200
        expect(response).to be_ok
      end

      it 'headers include content-type' do 
        expect(response.headers["Content-Type"]).to eq("application/json")
      end
      
      it 'returns response body including reset_current_player, reset_current_marker & new_grid' do 
        expect(response.body).to include("{\"reset_current_player1_name\":\"Human\",\"reset_current_player_marker\":\"X\",\"new_grid\":\"[\\\"1\\\", \\\"2\\\", \\\"3\\\", \\\"4\\\", \\\"5\\\", \\\"6\\\", \\\"7\\\", \\\"8\\\", \\\"9\\\"]\"}")
      end

    end

    context "GET computer vs human game" do 
      let(:response){ get '/start-game/2'}

      it 'returns status 200 OK' do
        expect(response.status).to eq 200
        expect(response).to be_ok
      end

      it 'headers include content-type' do 
        expect(response.headers["Content-Type"]).to eq("application/json")
      end
      
      it 'returns response body including reset_current_player, reset_current_marker & new_grid' do 
        expect(response.body).to include("{\"reset_current_player1_name\":\"Computer\",\"reset_current_player_marker\":\"X\",\"new_grid\":\"[\\\"1\\\", \\\"2\\\", \\\"3\\\", \\\"4\\\", \\\"5\\\", \\\"6\\\", \\\"7\\\", \\\"8\\\", \\\"9\\\"]\"}")
      end
    end

  end
end

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
        expect(response.status).to eq(200)
        expect(response).to be_ok
      end

    end

    context "GET computer vs human game" do 
      let(:response){ get '/start-game/2'}

      it 'returns status 200 OK' do
        expect(response.status).to eq(200)
        expect(response).to be_ok
      end

    end

  end
end

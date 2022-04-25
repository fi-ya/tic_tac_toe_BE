require 'app'
require 'rack/test'

RSpec.describe 'app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'playing the game' do
    context 'GET 1 human vs human game' do
      let(:response) { get '/start-game/1' }

      it 'expected successful return' do
        expect(response.status).to eq 200
        expect(response).to be_ok
        expect(response.headers['Content-Type']).to eq('application/json')
      end

      it 'supports sending :params' do
        request '/start-game/', params: { 'game_mode_token' => '1' }
        expect(last_request.GET['game_mode_token']).to eq('1')
      end

      it 'returns response body including reset_current_player, reset_current_marker & new_grid' do
        expect(response.body).to include("{\"player1_name\":\"Human\",\"player1_marker\":\"X\",\"new_grid\":\"[\\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\"]\"}")
      end
    end

    context 'GET 2 computer vs human game' do
      let(:response) { get '/start-game/2' }

      it 'expected successful return' do
        expect(response.status).to eq 200
        expect(response).to be_ok
        expect(response.headers['Content-Type']).to eq('application/json')
      end

      it 'returns response body including reset_current_player, reset_current_marker & new_grid' do
        expect(response.body).to include("{\"player1_name\":\"Computer\",\"player1_marker\":\"X\",\"new_grid\":\"[\\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\"]\"}")
      end
    end
  end

  describe '/start-game/grid' do
    let(:response) { put '/start-game/grid', '[[" ", " ", " ", " ", " ", " ", " ", " ", " "], "X", [" ", "0"]' }

    xit 'returns status 200 OK' do
      expect(response.status).to eq 200
      expect(response).to be_ok
    end

    it 'returns a response body containing an updated game' do
      expect(response.body).to eq("{\"updated_grid\":\"[\\\"X\\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\", \\\" \\\"]\",\"current_player_name\":\"Human\",\"current_player_marker\":\"O\",\"game_status\":\"Keep playing\",\"winner\":\"X\"}")
    end
  end

  describe '/start-game/computer_move' do 
    let(:response) { put '/start-game/computer_move', '["[\"1\", \"2\", \"3\", \"4\", \"5\", \"6\", \"7\", \"8\", \"9\"]", "X"]' }

    it 'returns status 200 OK' do
      expect(response.status).to eq 200
      expect(response).to be_ok
    end

    xit 'returns a response body containing an updated game' do
      expect(response.body).to eq("{\"updated_grid\":\"[\\\"X\\\", \\\"2\\\", \\\"3\\\", \\\"4\\\", \\\"5\\\", \\\"6\\\", \\\"7\\\", \\\"8\\\", \\\"9\\\"]\",\"current_player_name\":\"Human\",\"current_player_marker\":\"O\",\"game_status\":\"Keep playing\",\"winner\":\"X\"}")
    end
  end

end

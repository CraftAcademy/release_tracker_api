RSpec.describe Api::V1::SearchesController, type: :request do
  describe 'GET /api/v1/searches/ successfully' do
    before do
      get '/api/v1/searches/',
          params: {
            q: 'Will Smith'
          }
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end
    
    it "successfully returns type of person result" do
      expect(response_json['data']['people'][0]['type']).to eq 'person'
    end
    
    it "for person, successfully returns id" do
      expect(response_json['data']['people'][0]['id']).to eq 2888
    end

    it 'for person, successfully returns name' do
      expect(response_json['data']['people'][0]['name']).to eq 'Will Smith'
    end

    it "for person, successfully returns related movie title" do
      expect(response_json['data']['people'][0]['known_for_movie']).to eq 'Suicide Squad'
    end

    it "for person, successfully returns role" do
      expect(response_json['data']['people'][0]['known_for_role']).to eq 'Acting'
    end
    
    it "successfully returns type of movie result" do
      expect(response_json['data']['movies'][0]['type']).to eq 'movie'
    end
    
    it "for upcoming movie, successfully returns id" do
      expect(response_json['data']['movies'][0]['id']).to eq 2027
    end

    it 'for upcoming movie, successfully returns title' do
      expect(response_json['data']['movies'][0]['title']).to eq 'I Am Legend 2027 remake'
    end

    it "for upcoming movie, successfully returns release date" do
      expect(response_json['data']['movies'][0]['release_date']).to eq '2027-12-14'
    end

    it "for upcoming movie, successfully returns overview" do
      expect(response_json['data']['movies'][0]['overview']).to eq 'Robert Neville is a scientist. But he is not alone. Not even in 2027'
    end
  end

  describe 'GET /api/v1/searches/ unsuccessfully' do
    before do
      get '/api/v1/searches/',
          params: {
            q: ''
          }
    end

    it 'empty query should return a 422 response' do
      expect(response).to have_http_status 422
    end

    it 'empty query returns error message' do
      expect(response_json['data']['errors'][0]).to eq "query must be provided"
    end
  end
end

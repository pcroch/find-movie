require 'rails_helper'
require 'spec_helper'

### Integration testing
RSpec.describe 'Integration testing Finder Controller', type: :request do


  # Test suite for GET /articles
  describe 'Index testing' do
    # make HTTP get request before each example
    before do
     get "http://localhost:3000/api/v1/finders"  end


    it 'returns list of events' do
      # Note `json` is a custom helper to parse JSON responses
      expect(response.body).not_to be_empty
      # expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
end

describe 'Create testing' do

  let!(:user) { UUser.create(email: "Bob@Bob.Bob", password: 'testest', user_name: "BobUser", authentication_token: "KdapjiY6vz-sBkKmNabc") }

    before do
    post "http://localhost:3000/api/v1/finders",

    params: { "finder": {
        "release": "2008-12-18",
        "duration": "210",
        "attendees": ["Pierre", "Bob", "Fred"],
        "rating": ["5", "10"]
      }
       }, headers: { 'X-Username': user.username, 'X-Token': user.authentication_token }


    it 'returns list of events' do
      # Note `json` is a custom helper to parse JSON responses
      expect(response.body).not_to be_empty
      # expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
end

end

end


# naming of the testing
# other testing to be done
# model validation to be done

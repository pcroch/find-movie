require 'rails_helper'
require 'spec_helper'

### Integration testing
RSpec.describe 'Integration testing Finder Controller', type: :request do


  #  event = Finder.new(release: "2008", duration: "200", rating: ["5", "10"], user_id: "1")
  #  event.save
  # Preference.create(user_id: 2, name: "Bob", finder_id: 1, content: ["Adventure", "Family", "Horror"])
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

# describe 'Create testing' do

#    let!(:user) { User.create(email: "crochet@pierre.pierre", password: 'testest', user_name: "PierreUser", authentication_token: "KdapjiY6vz-sBkKmNabc", id: 1) }
#     let!(:event) {Finder.create(release: "2008", duration: "200", rating: ["5", "10"], user_id: "1")}
#    let!(:pref) {Preference.create(user_id: 1, name: "Pierre", finder_id: 1, content: ["Action", "Comedy", "Horror"])}

#     before do

#     post "http://localhost:3000/api/v1/finders",

#     params: { "finder": {
#         "release": "2008-12-18",
#         "duration": "210",
#         "attendees": ["Pierre", "Bob", "Fred"],
#         "rating": ["5", "10"]
#       }
#        }, headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token }

# end
#     it 'returns correct' do


#          json_response = JSON.parse(response.body)
#       expect(json_response).to eq("Sign Up Successfully")
#     end

#     it 'returns status code created 201' do
#       expect(response).to have_http_status(201)
#     end


# end

end

# testing the model first?
# create preference after

# naming of the testing
# other testing to be done
# model validation to be done

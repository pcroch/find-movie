require 'rails_helper'
require 'spec_helper'

### Integration testing


RSpec.describe 'Integration testing User Controller', type: :request do


  # Test suite for GET /articles
  describe 'Sign up' do
    # make HTTP get request before each example
#     before do
#     post "http://localhost:3000/api/v1/sign_up"
#    # headers['Content-Type'] = 'application/json'
#    request.headers['Content-Type'] = 'application/vnd.api+json'
#     request.body  {
#  "user": {
#   "email": "4444@example.com",
#   "password": "password",
#   "password_confirmation": "password",
#       "user_name": "qwerty"
#  }
# }
#    end
before do
    post "http://localhost:3000/api/v1/sign_up", params: {
           "user": {
            "email": "9@example.com",
            "password": "password",
            "password_confirmation": "password",
                "user_name": "qwerty"
           }
          }
end


    it 'returns list of events' do
      json_response = JSON.parse(response.body)
      expect(json_response["messages"]).to eq("Sign Up Successfully")
      # $token = json_response["data"]["user"]["authentication_token"]
      # expect(token).to eq("Sign Up Successfully")

    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
end
end





# how to describe testing
# eding all the testint

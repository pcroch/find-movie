# frozen_string_literal: true

RSpec.describe 'Error handeling testing when creating an event:', type: :request do
  describe 'Missing the release params' do
    let!(:user) { User.create(email: 'test@test.test', password: 'testest', user_name: 'TestUser', authentication_token: 'KdapjiY6vz-sBkKmNabc', id: 1) }
    let!(:pref) { Preference.create(user_id: 1, name: 'Test', content: %w[Action Comedy Horror]) }

    before do
      sample_body = { "finder": {

        "duration": 200,
        "attendees": ['Test'],
        "rating": [0, 10]
      } }

      post 'http://localhost:3000/api/v1/finders', params: sample_body, headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token }
    end
    error = { 'errors' => ['Release : The integer must be a 4 digits', "Release can't be blank"] }

    it 'returns an error message' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq(error)
    end

    it 'returns status code created 422' do
      expect(response).to have_http_status(422)
    end
  end

  describe 'A Negatif Release params' do
    let!(:user) { User.create(email: 'test@test.test', password: 'testest', user_name: 'TestUser', authentication_token: 'KdapjiY6vz-sBkKmNabc', id: 1) }
    let!(:pref) { Preference.create(user_id: 1, name: 'Test', content: %w[Action Comedy Horror]) }

    before do
      sample_body = { "finder": {
        "release": -2,
        "duration": 200,
        "attendees": ['Test'],
        "rating": [0, 10]
      } }

      post 'http://localhost:3000/api/v1/finders', params: sample_body, headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token }
    end
    error = { errors: ['Duration must be a positive integer'] }

    it 'returns an error message' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq(error)
    end

    it 'returns status code created 422' do
      expect(response).to have_http_status(422)
    end
  end

  describe 'Release params length bigger than 4 digits' do
    let!(:user) { User.create(email: 'test@test.test', password: 'testest', user_name: 'TestUser', authentication_token: 'KdapjiY6vz-sBkKmNabc', id: 1) }
    let!(:pref) { Preference.create(user_id: 1, name: 'Test', content: %w[Action Comedy Horror]) }

    before do
      sample_body = { "finder": {
        "release": 10_000,
        "duration": 200,
        "attendees": ['Test'],
        "rating": [0, 10]
      } }

      post 'http://localhost:3000/api/v1/finders', params: sample_body, headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token }
    end
    error = { "errors": ['Release : The integer must be a 4 digits'] }

    it 'returns an error message' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq(error)
    end

    it 'returns status code created 422' do
      expect(response).to have_http_status(422)
    end
  end

  describe 'Missing the duration params' do
    let!(:user) { User.create(email: 'test@test.test', password: 'testest', user_name: 'TestUser', authentication_token: 'KdapjiY6vz-sBkKmNabc', id: 1) }
    let!(:pref) { Preference.create(user_id: 1, name: 'Test', content: %w[Action Comedy Horror]) }

    before do
      sample_body = { "finder": {

        "release": 1900,
        "attendees": ['Test'],
        "rating": [0, 10]
      } }

      post 'http://localhost:3000/api/v1/finders', params: sample_body, headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token }
    end
    error = { 'errors' => ["Duration can't be blank", 'Duration must be a positive integer'] }

    it 'returns an error message' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq(error)
    end

    it 'returns status code created 422' do
      expect(response).to have_http_status(422)
    end
  end

  describe 'Negatif Duration params size' do
    let!(:user) { User.create(email: 'test@test.test', password: 'testest', user_name: 'TestUser', authentication_token: 'KdapjiY6vz-sBkKmNabc', id: 1) }
    let!(:pref) { Preference.create(user_id: 1, name: 'Test', content: %w[Action Comedy Horror]) }

    before do
      sample_body = { "finder": {
        "release": 1900,
        "duration": -2,
        "attendees": ['Test'],
        "rating": [0, 10]
      } }

      post 'http://localhost:3000/api/v1/finders', params: sample_body, headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token }
    end
    error = { 'errors' => ['Duration must be a positive integer'] }

    it 'returns an error message' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq(error)
    end

    it 'returns status code created 422' do
      expect(response).to have_http_status(422)
    end
  end

  describe 'Missing the rating params' do
    let!(:user) { User.create(email: 'test@test.test', password: 'testest', user_name: 'TestUser', authentication_token: 'KdapjiY6vz-sBkKmNabc', id: 1) }
    let!(:pref) { Preference.create(user_id: 1, name: 'Test', content: %w[Action Comedy Horror]) }

    before do
      sample_body = { "finder": {
        "release": 1900,
        "duration": 190,

        "attendees": ['Pierre']

      } }

      post 'http://localhost:3000/api/v1/finders', params: sample_body, headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token }
    end
    error = { 'errors' => ["Rating can't be blank", 'Rating must be an array of two elements'] }

    it 'returns an error message' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq(error)
    end

    it 'returns status code created 422' do
      expect(response).to have_http_status(422)
    end
  end

  describe 'Missing the attendees params' do
    let!(:user) { User.create(email: 'test@test.test', password: 'testest', user_name: 'TestUser', authentication_token: 'KdapjiY6vz-sBkKmNabc', id: 1) }
    let!(:pref) { Preference.create(user_id: 1, name: 'Test', content: %w[Action Comedy Horror]) }

    before do
      sample_body = { "finder": {
        "release": 1900,
        "duration": 190,
        "rating": [1, 10]

      } }

      post 'http://localhost:3000/api/v1/finders', params: sample_body, headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token }
    end
    error = { 'errors' => ["attendees can't be blank", 'attendees must be an array of at least one elements'] }

    it 'returns an error message' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq(error)
    end

    it 'returns status code created 422' do
      expect(response).to have_http_status(422)
    end
  end

  describe 'Empty response' do
    let!(:user) { User.create(email: 'test@test.test', password: 'testest', user_name: 'TestUser', authentication_token: 'KdapjiY6vz-sBkKmNabc', id: 1) }
    let!(:pref) { Preference.create(user_id: 1, name: 'Test', content: %w[Action Comedy Horror]) }

    before do
      sample_body = { "finder": {
        "release": 1900,
        "duration": 190,
        "rating": [1, 10]

      } }

      post 'http://localhost:3000/api/v1/finders', params: sample_body, headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token }
    end
    error = { 'errors' => ['No movie found'] }

    it 'returns an warning message' do
      json_response = JSON.parse(response.body)
      expect(json_response).to eq(error)
    end

    it 'returns status code created 404' do
      expect(response).to have_http_status(404)
    end
  end
end

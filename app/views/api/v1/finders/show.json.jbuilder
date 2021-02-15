# frozen_string_literal: true

# json.cache! ['finders'], expires_in: 1.minutes do |json|
  json.extract! @finder, :id, :release

  json.movies @finder.movies do |movie|
    json.extract! movie, :title, :overview, :vote_average
  end
# end

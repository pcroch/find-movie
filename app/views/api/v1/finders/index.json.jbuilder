# frozen_string_literal: true

# json.array! @finders do |finder|
#   cache finder do
#     json.extract! finder, :id, :duration, :rating
#     json.movies finder.movies, :title, :overview, :vote_average
#   end
# end

json.cache! ['finders'], expires_in: 3.minutes do |json|
  json.array! @finders do |finder|

      json.extract! finder, :id, :duration, :rating
      json.movies finder.movies, :title, :overview, :vote_average
    end

end

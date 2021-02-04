# frozen_string_literal: true

json.extract! @finder, :id, :release

json.movies @finder.movies do |movie|
  json.extract! movie, :title, :overview, :vote_average
end

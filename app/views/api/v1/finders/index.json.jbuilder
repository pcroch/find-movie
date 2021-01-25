# json.array! @finders do |finder|
#   json.extract! finder, :id, :duration, :language, :rating
#   json.array! finder.movies, :title, :overview, :vote_average
# end

json.array! @finders do |finder|
  # binding.pry=begin=end
json.extract! finder, :id, :duration, :language, :rating
json.movies finder.movies, :title, :overview, :vote_average
# json.movies! @finders.movies do |movie|
# json.extract! movie, :title, :overview, :vote_average
#   end
end

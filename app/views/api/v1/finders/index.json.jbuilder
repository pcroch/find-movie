
json.array! @finders do |finder|

json.extract! finder, :id, :duration, :language, :rating
json.movies finder.movies, :title, :overview, :vote_average

end

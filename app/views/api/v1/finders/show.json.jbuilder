# p  json
json.extract! @finder, :id, :release
json.movies @finder.movies do  |movie|
json.extract! movie, :title, :overview, :vote_average
  end
#
# json.comments @finder.preference do |pref|
#   json.extract! comment, :id, :content

# json.rating @finder.rating do |item|
#   json.array! item
# end



# json.language @finder.language
# json.array!

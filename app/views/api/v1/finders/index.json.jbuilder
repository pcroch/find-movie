json.array! @finders do |finder|
  json.extract! finder, :id, :duration, :language, :rating
end

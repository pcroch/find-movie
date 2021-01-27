json.array! @preferences do |preference|
  json.extract! preference, :name, :content
end

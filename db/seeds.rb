# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(email: "pierre@pierre.pierre", password: 'testest', user_name: "PierreUser", authentication_token: "KdapjiY6vz-sBkKmNieF")
User.create(email: "Bob@Bob.Bob", password: 'testest', user_name: "BobUser")
User.create(email: "Fred@Fred.Fred", password: 'testest', user_name: "FredUser")
User.create(email: "John@John.John", password: 'testest', user_name: "JohnUser")

# # finder
# event = Finder.new(release: "2008", duration: "200", rating: ["5", "10"], user_id: "1")
# event.save
# # preferences
Preference.create(user_id: 1, name: "Pierre", content: ["Action", "Comedy", "Horror"])
Preference.create(user_id: 2, name: "Bob", content: ["Adventure", "Family", "Horror"])
Preference.create(user_id: 2, name: "Fred", content: ["Adventure", "Comedy", "Horror"])
Preference.create(user_id: 4, name: "John", content: ["Adventure", "Drama", "Western"])

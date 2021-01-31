
# Creating Mock user
User.create(email: "pierre@pierre.pierre", password: 'testest', user_name: "PierreUser", authentication_token: "KdapjiY6vz-sBkKmNieF")
User.create(email: "Bob@Bob.Bob", password: 'testest', user_name: "BobUser")
User.create(email: "Fred@Fred.Fred", password: 'testest', user_name: "FredUser")
User.create(email: "John@John.John", password: 'testest', user_name: "JohnUser")

# # finder
# event = Finder.new(release: "2008", duration: "200", rating: ["5", "10"], user_id: "1")

# # preferences
Preference.create(user_id: 1, name: "Pierre", content: ["Action"])
Preference.create(user_id: 2, name: "Bob", content: ["Comedy", "Action", "Horror"])
Preference.create(user_id: 2, name: "Fred", content: ["Action", "Comedy", "Horror"])
Preference.create(user_id: 4, name: "John", content: ["Action", "Comedy", "Horror"])

The documents will come soon

Description

Testing


For rating params, only the two first value are take into account -> solved and validation through model now



Know bug:
N/A

Validatio done through the controller?
Yes 

https://movie-api-finder.herokuapp.com/ for the api

get https://movie-api-finder.herokuapp.com/api/v1/finders index
get https://movie-api-finder.herokuapp.com/api/v1/finders/:id show
post https://movie-api-finder.herokuapp.com/api/v1/finders/:id create
  Body: { "finder": { 
        "release": 1990,
        "duration": 1,
        "attendees": ["Bob"],
        "rating": [0,1,3, 1] } }

improving the rendering in index, show and create as some variable are no longer used anymore
testing to end and model valdiation too



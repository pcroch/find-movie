The documents will come soon

Description

Testing


For rating params, only the two first value are take into account -> solved and validation through model now



Know bug:
rendering the previous request if the API fetch an empty json==> the gem must be the issue
Validation in rating and attenddes, if blank, API reponsd a 400 message bcse Date format is wrong: should be yyyy-mm-dd instead of yyyy

Validatio done through the controller?
Yes 
And partioally through the model

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



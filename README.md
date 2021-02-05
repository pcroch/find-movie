The documents will come soon

# Api description: An api to find mvoeis based to criteria

## I. General description

Basically, my api will render a list one ten movies maximum based on the following criterias: Year of release, the rating range, your tastes, the others attendees tastes. My api uses an external api to discover movies based on those criterias.

## II. Technical description

### Current version: 

      Version 1 is actually the production one.

### End-points: 
    
    Production: https://movie-api-finder.herokuapp.com/api/v1/finders
    In testing: URL: http://localhost:3000/api/v1/finders
 
### Installation:  

  
    1 * launch and install the rails server with the following command:
        git clone git@github.com:pcroch/
        cd bfinder-movie 
        yarn install && bundle install
        rails db:create db:migrate db:seed
        rails s
        
### How to fetch:  

    1 * Headers:
        Content-Type    application/json
        X-User-Email    pierre@pierre.pierre
        X-User-Token    KdapjiY6vz-sBkKmNieF
        
     This is a default user to demonstration.
     
    1 * Body: 
     For example: A raw body request
      { "finder": {
        "release": 2008,
        "duration": 90,
        "rating": [1, 10],
        "attendees": ["Pierre"]
       }}

Know bug:
valiadtion of datas


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



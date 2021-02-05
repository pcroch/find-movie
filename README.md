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
        
### How to fetch in short:  

    1 * Headers:
        Content-Type    application/json
        X-User-Email    pierre@pierre.pierre
        X-User-Token    KdapjiY6vz-sBkKmNieF
        
     This is a default user to demonstration. You can of course create your own user. PLease see below.
     
    2 * Body: 
       { "finder": {
        "release": 2008,
        "duration": 90,
        "rating": [1, 10],
        "attendees": ["Pierre"]
       }}
       
      This is an example of a  raw body request

### III. HOW TO


#### Sign-up the API
  When you sin in, you **MUST** keep the authentication_token otherwise you won't be able to sign when create new event.
  
  
  Fetch: 
  
      curl -i -X POST                                                                                                                     \
            -H 'Content-Type      application/json'                                                                                       \
            -d '{"user": {"email":"4444@example.com","password":"password", "password_confirmation":"password", "user_name": "qwerty" }}' \
            localhost:3000/api/v1/sign_up
  Render: 
      
      {
    "messages": "Sign Up Successfully",
    "is_success": true,
    "data": {
        "user": {
            "id": 5,
            "email": "4444@example.com",
            "user_name": "qwerty",
            "created_at": "2021-02-05T11:48:26.940Z",
            "updated_at": "2021-02-05T11:48:26.940Z",
            "authentication_token": "4xxvRjtXFUPPMubjs94t"
        }
    }
    }

#### Index Action: Get of the db
  Fetch:
            
    curl -s https://movie-api-finder.herokuapp.com/api/v1/finders | jq
      
  Render: 
      
      [
    {
        "id": 1,
        "duration": "210",
        "rating": [
            "0",
            "10"
        ],
        "movies": [
            {
                "title": "The Lord of the Rings: The Return of the King",
                "overview": "Aragorn is revealed as the heir to the ancient kings as he, Gandalf and the other members of the broken fellowship struggle to save Gondor from Sauron's forces. Meanwhile, Frodo and Sam take the ring closer to the heart of Mordor, the dark lord's realm.",
                "vote_average": "8.5"
            },
            {
                "title": "The Lord of the Rings: The Two Towers",
                "overview": "Frodo and Sam are trekking to Mordor to destroy the One Ring of Power while Gimli, Legolas and Aragorn search for the orc-captured Merry and Pippin. All along, nefarious wizard Saruman awaits the Fellowship members at the Orthanc Tower in Isengard.",
                "vote_average": "8.3"
            }
        ]
    },
    {
        "id": 2,
        "duration": "210",
      **etc ...**
      ]    




#### Show Action: Get a specific event on the db
  Fetch:
  
    curl -s https://movie-api-finder.herokuapp.com/api/v1/finder/:id | jq
    Where id is the id of the event. It must be an integer
 Render:  
      
    if id: 1
    
    {
    "id": 1,
    "release": "1990",
    "movies": [
        {
            "title": "The Lord of the Rings: The Return of the King",
            "overview": "Aragorn is revealed as the heir to the ancient kings as he, Gandalf and the other members of the broken fellowship struggle to save Gondor from Sauron's forces. Meanwhile, Frodo and Sam take the ring closer to the heart of Mordor, the dark lord's realm.",
            "vote_average": "8.5"
        },
        {
            "title": "The Lord of the Rings: The Two Towers",
            "overview": "Frodo and Sam are trekking to Mordor to destroy the One Ring of Power while Gimli, Legolas and Aragorn search for the orc-captured Merry and Pippin. All along, nefarious wizard Saruman awaits the Fellowship members at the Orthanc Tower in Isengard.",
            "vote_average": "8.3"
        }
    ]
}
    

#### Create Action: create an event via a post reauest
   You need to be authenticated and of course have the authorization. It is granted when you sign up.

Fetch: 
   
    curl -i -X POST 
        -H 'Content-Type    application/json'                                                           \
        -H 'X-User-Email    pierre@pierre.pierre'                                                       \
        -H 'X-User-Token    KdapjiY6vz-sBkKmNieF'                                                       \
        -d '{ "finder": {"release": 2020,"duration": 190,"attendees": ["Bob"],"rating": [0,1,3, 1] } }' \
        https://movie-api-finder.herokuapp.com/api/v1/finders 
Render:   
         
         {
          "id": 200,
          "release": "2020",
          "movies": [
              {
                  "title": "Possessor Uncut",
                  "overview": "Tasya Vos, an elite corporate assassin, uses brain-implant technology to take control of other people’s bodies to terminate high profile targets. As she sinks deeper into her latest assignment, Vos becomes trapped inside a mind that threatens to obliterate her.",
                  "vote_average": "6.6"
              }
          ]
      } 
        
### B- Cross-origin resource sharing        
        
(CORS) is already setup and so the api is ready to be used in production.

### C- Error rendering description:

Coming soon
improving the rendering in index, show and create as some variable are no longer used anymore
testing to end and model valdiation too

## III. Testing description

Coming soon


## IV. Waht next?

### A- To do list:

      valiadtion of datas for duration and attendees
      CORS end set up
      index rendering removing language
      creating an admin with full right to delete
      testing destroy and update
      end descripton of test case
      
### B- Know bug + Description:
      
      valiadtion of datas for duration and attendees> If blank, the api crash...

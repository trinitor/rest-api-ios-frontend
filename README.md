# About
Json REST API iOS frontend template  
I've started with swift only recently. Suggestions are very welcome.  
A working backend can be found here: https://github.com/trinitor/rest-api-rails-backend

## Screenshots  
![Login](/doc/screenshots/01_login.jpg?raw=true "Login")
![Create account](/doc/screenshots/02_create_account.jpg?raw=true "Create account")
![Show friends](/doc/screenshots/03_show_friends.jpg?raw=true "Show friends")
![Add friends](/doc/screenshots/04_add_friends.jpg?raw=true "Add friends")

## Features
- token based authentication
- create user accounts
- create friendships (two way)
- push notifications
- uses swifyjson (https://github.com/SwiftyJSON/SwiftyJSON)

## Login
The tab controller is the entry point. The Data view is the first one.  
Inside that controller there is a check if the users was logged in before.  
If the username it not stored (NSUserDefaults) it will show the login form  

## API
APIController.swift offers a protocol.
You can include the protocol in controller, send the API call and get the results back as JSON (swiftyjson)

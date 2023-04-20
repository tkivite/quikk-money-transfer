# Introduction

This is an API app can enable users to register and send money to each other within the system. They top up their accounts through MPESA* and can now transfer amongst themselves. They use the registered number or email address to transfer.  Once a transfer is done, the recipient receives a notification in the system as well as a confirmation through email. A user should be able to trigger an email report summarising all the transactions they have done for a selected number of days. The users will use the application mostly on their phones so it should work well on a mobile browser. 


# pre-requisites (tools):
- ruby (v3.1.0)
- Rails (v7.0.4)
- bundler (v2.2.3)
- postgreSQL
- jwt
- sidekiq 
- rubocop
- postman



# Setup

Clone the app from github and navigate to the project folder
Run this command to install required libraries
```
bundle install
```
Setup db
Create evironment config file config/initializers/dev_env.rb and add the following variables
```
ENV["DEV_DB_URL"] = "postgres://username:password@localhost/dbname"
ENV["TEST_DB_URL"] = "postgres://username:password@localhost/dbname"
ENV["PROD_DB_URL"] = "postgres://username:password@localhost/dbname"
```

Run the following commands
```
rails db:create
rails db:migrate
rails db:seed
```
# Run the tests
```
rspec
```
All tests should be green
# Start the app

- rails s

# Usage

## Sample Requests

The API is curently hosted here
https://quick-apis.herokuapp.com/

Postman collection

https://documenter.getpostman.com/view/1917118/2s93Y3ugCX
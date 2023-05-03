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





Proposed improvements: TODO

1. Model Accounts: Add default currency, default balance
2. Model User - Add callback after_create to create user account, remove logic from user controller
3. Change resource named request across the application to statement_requests
4. On Transaction remove currency , add currency validation during transfer
5. Move self.implicit_order_column = 'created_at' to default model
6. Implement Balance updates as callback in the transaction model ( after_create) so they can be performed as a transaction in the db
7. Frontend screens -  register, updating of balances, update dashboard transactions during topup and fundstransfer

7. API versioning *
8. 




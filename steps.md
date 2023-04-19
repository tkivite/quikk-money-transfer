rails generate resource Notification message:text recipient:string scheduled:boolean notification_type:integer datetime:datetime

rails generate resource User surname:string othernames:string email:string mobile:string password_digest:string status:integer 
rails generate resource Account account_number:string currency:string balance:decimal status:integer
rails generate resource Transaction currency:string amount:decimal date_of_transaction:datetime status:integer

rails generate resource Request request_type:integer start_date:datetime end_date:datetime status:integer

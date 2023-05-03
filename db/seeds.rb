# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def seed_admin_user
    
    User.create(
    surname: 'admin',
    othernames: 'system user',
    email: 'admin@quikk.com',
    mobile: '254700000000',
    password: 'Admin321',
    status: 1      
    )
      
end

def seed_account
    user = User.first
    Account.create(
    account_number: 'Holding_0001',
    user_id: user.id,
    currency: 'KES',
    balance: 1000000000.00  
    )
      
end

seed_admin_user
seed_account
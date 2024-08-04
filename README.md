# README

This README file provides instructions for setting up and running a Ruby on Rails project with the following specifications:

Ruby version: 3.0.0
Rails version: 7.1.3 (minimum 7.1.3.4)

-Prerequisites-
Ensure you have the following installed on your system:

Ruby 3.0.0: You can use a version manager like rbenv or RVM to manage Ruby versions.
Bundler: A gem that manages gem dependencies. It should be installed globally. You can install it by running:

1. Clone the Repository
Clone the project repository to your local machine:

    git clone https://github.com/ravisonipro/Webhook_system.git
    cd webhook_system

2. Install Ruby Version
If you are using a version manager like RVM, set the Ruby version to 3.0.0:

   rvm install 3.0.0
   rvm use 3.0.0

3. Install Dependencies
Install the necessary gems using Bundler:

   bundle install
   
5. Database Setup
Set up the database by running the following commands:

   rails db:create
   rails db:migrate

5. Run the Server
Start the Rails server:

  rails s

6. Running Tests
To run the test suite, use the following command:

  rspec


# To interact with the webhook API for payments in the project, you can use the following curl commands:

 -Create a New Payment
 To create a new payment, use the POST request:

    curl -X POST http://localhost:3000/payments -H "Content-Type: application/json" -d '{"payment": {"amount": 2000, "note": "Test2"}}'

 -Update an Existing Payment
 To update an existing payment, use the PUT request. Replace 1 with the ID of the payment you want to update:

    curl -X PUT http://localhost:3000/payments/1 -H "Content-Type: application/json" -d '{"payment": {"amount": 25000, "note": "Updated Note"}}'







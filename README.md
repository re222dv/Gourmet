# Gourmet

## Instructions
Gourmet depends on Elasticsearch so the first thing you need to do is download and start
Elasticsearch with default settings.

1. Get the dependencies
    `bundle install`
1. Install Locksmith migrations
    `rake locksmith:install:migrations`
1. Create the database
    `rake db:migrate`
1. Seed the database
    `rake db:seed`
    `rake app:locksmith:populate`
1. Start the rails server
    `rails s`
1. Import the Postman collection from url
    `https://www.getpostman.com/collections/7c1430981314b38ee5c4`

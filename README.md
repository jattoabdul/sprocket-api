# README

API serving a product search react page as part of Sprocket Test

* Ruby version
- '2.5.6'

* System dependencies
- Rails ~> 5.2.1', '>= 5.2.1.1'
- SearchKick ~> latest
- Redis ~> 4.1

* Configuration
- API Documentation => https://documenter.getpostman.com/view/1203729/SWT8hfF3

* Database creation
- rails db:setup

* Database initialization
- rails db:migrate
- rails db:seed

* How to run the test suite
- rspec

* Services (job queues, cache servers, search engines, etc.)
Alway run below code after any database operation in the heroku console:
- `rails searchkick:reindex CLASS=Product`

This is so due to the inability to setup a queue system like sidekiq.

* Deployment instructions
- Push to heroku (heroku create app-name && git push heroku master)

* ...

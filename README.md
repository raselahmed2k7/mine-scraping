# flight-scraping

* Ruby version
  ruby '2.7.1', rails version > 6

* System dependencies
  Selenium web driver, MySQL,

* Database creation
  Run `rails db:migrate`

* Database initialization
  Run `rails db:seed`

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions for local
  Run `bundle install`
  ```bash
  cp config/database.sample.yml config/database.yml
  ```
  start `rails server`
  go to `rails console` and call the active job by executing `FlightScraperJob.perform_later`

That's it. It will then start scraping.
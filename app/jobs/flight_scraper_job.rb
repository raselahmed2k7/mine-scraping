class FlightScraperJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ScraperService.start_scraping
  end
end

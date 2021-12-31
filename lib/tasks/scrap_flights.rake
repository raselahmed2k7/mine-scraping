namespace :scraper do
  desc "Flight tickets scraping.."

  task :scrap_flights => :environment do
   ScraperService.start_scraping
  end
end

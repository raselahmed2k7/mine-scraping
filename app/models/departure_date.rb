class DepartureDate < ApplicationRecord
    has_many :searches
    scope :scraping_departure_dates, ->{ where('departure_date > ?', Date.today) }
end


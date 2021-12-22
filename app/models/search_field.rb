class SearchField < ApplicationRecord
    belongs_to :airports
    belongs_to :departure_dates
    has_many :flights
end

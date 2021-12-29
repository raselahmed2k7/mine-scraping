class Search < ApplicationRecord
    belongs_to :airport
    belongs_to :departure_date
    has_many :flights
end

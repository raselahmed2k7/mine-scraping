class Flight < ApplicationRecord
    belongs_to :airlines
    belongs_to :search_fields
end

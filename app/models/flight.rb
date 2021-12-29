class Flight < ApplicationRecord
    belongs_to :airline
    belongs_to :search
end

class Station < ApplicationRecord
	validates :number, presence: true, uniqueness: true
end

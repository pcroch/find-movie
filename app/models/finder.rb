class Finder < ApplicationRecord
  belongs_to :user
  has_many :preferences
end

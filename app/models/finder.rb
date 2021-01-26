class Finder < ApplicationRecord
  belongs_to :user
  has_many :preference_finders
  has_many :preferences, :through => :preference_finders
  has_many :movies
end

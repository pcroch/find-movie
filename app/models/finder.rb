class Finder < ApplicationRecord
  belongs_to :user
  has_many :preference_finders
  has_many :preferences, through: :preference_finders
  has_many :movies

  validates :duration, presence: true, numericality: { greater_than: 0, message: 'must be a positive integer' }
  validates :release, format: { with: /\d{4}/, message: ': The integer must be a 4 digits' }, presence: true
  # validates :attendees, presence: true
  validates :rating, presence: true
end

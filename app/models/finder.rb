class Finder < ApplicationRecord
  belongs_to :user
  has_many :preference_finders
  has_many :preferences, :through => :preference_finders
  has_many :movies

  # validates_presence_of :release, presence: true
  # validates :duration, absence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :release, format: { with: /\d{4}/ }
  # validates :rating,  length: {
  #   maximum: 2,
  #   message: 'A note can only have a maximum of 10 tags'
  # }
  # validates :rating, length: { maximum: 2 }

# validates :rating, inclusion: %w(5 10)
# validates_inclusion_of :rating, in: [5,10]
  # def active_customer
  #   errors.add(:rating, "is not active") if  rating.size > 2
  # end


end
 #

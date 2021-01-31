require 'pry'
class Finder < ApplicationRecord


  belongs_to :user
  has_many :preference_finders
  has_many :preferences, :through => :preference_finders
  has_many :movies

  validates :duration, presence: true, numericality: { greater_than: 0 }
  # validates :release, format: { with: /\d{4}/ }
  validate :myrelease
  validate :myrating



  def myrelease
    # regex = /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/
    regex =  /\d{4}/

    errors.add(:release, ": the date foramt is incorrect") unless release.match(regex)
  end

  def myrating
  # binding.pry
  # maximum count value but seems useless
  errors.add(:rating, "element is superior than 2") unless rating.count <= 2
  end

end
 #

# les eleents dans le model sont ceux du controlleurs...
# DOnc jai deja fait la validations dan le controller?

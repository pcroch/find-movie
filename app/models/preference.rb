class Preference < ApplicationRecord
  has_many :preference_finders
  has_many :finders, :through => :preference_finders
  belongs_to :user
end

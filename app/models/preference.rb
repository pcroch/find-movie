class Preference < ApplicationRecord

  has_many :preference_finders
  has_many :finders, :through => :preference_finders
  belongs_to :user
  validates :name, uniqueness: { case_sensitive: false, message: 'already in use'}, presence: true
  # To activate when ready but working== I need to end the sample
  # validate :myarray

  def myarray
    # Sample must be fuilled with rel value
    sample = ["Action", "Horror"]
    errors.add(:content, "doesn't match everywhere") unless content.all? {|w| sample.include?(w)}
  end

end

# frozen_string_literal: true

class Preference < ApplicationRecord
  has_many :preference_finders
  has_many :finders, through: :preference_finders
  belongs_to :user
  validates :name, uniqueness: { case_sensitive: false, message: 'already in use' }, presence: true
  # validate :myarray # the sample variable is not full so w ont work

  def myarray
    sample = %w[Action Horror]
    errors.add(:content, "doesn't match everywhere") unless content.all? { |w| sample.include?(w) }
  end
end

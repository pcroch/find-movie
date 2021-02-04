# frozen_string_literal: true

class PreferenceFinder < ApplicationRecord
  belongs_to :preference
  belongs_to :finder
end

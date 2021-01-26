class PreferenceFinder < ApplicationRecord
  belongs_to :preference
  belongs_to :finder
end

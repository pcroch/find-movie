class Preference < ApplicationRecord
  belongs_to :finder
  belongs_to :user
end

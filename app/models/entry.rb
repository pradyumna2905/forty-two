class Entry < ApplicationRecord
  before_save { self.word = word.downcase }

  has_many :records
end

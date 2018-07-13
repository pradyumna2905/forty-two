class Entry < ApplicationRecord
  serialize :definitions, Array

  before_save { self.word = word.downcase }
end

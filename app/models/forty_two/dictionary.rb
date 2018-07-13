class FortyTwo::Dictionary < ApplicationRecord
  serialize :response, JSON

  before_save { self.word = word.downcase }
end

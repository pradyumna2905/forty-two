class FortyTwo::Dictionary < ApplicationRecord
  serialize :response, OpenStruct

  before_save { self.word = word.downcase }
end

class Entry < ApplicationRecord
  before_save { self.word = word.downcase }

  has_many :records

  scope :saved, -> { where(saved: true) }
  scope :desc, -> { order(created_at: :desc) }
end

class Record < ApplicationRecord
  serialize :definitions, Array
  serialize :examples, Array
end

class Home < ActiveRecord::Base
  validates_uniqueness_of :mls_number
end

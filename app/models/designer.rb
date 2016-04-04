class Designer < ActiveRecord::Base
  validates_presence_of :name, :telephone, :enterprise
  validates_uniqueness_of :name, :telephone
end

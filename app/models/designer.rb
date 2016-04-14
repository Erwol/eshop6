class Designer < ActiveRecord::Base
  has_and_belongs_to_many :articles
  validates_presence_of :name, :telephone, :enterprise
  validates_uniqueness_of :name, :telephone
end

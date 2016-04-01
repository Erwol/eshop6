class Provider < ActiveRecord::Base
  validates_presence_of :name, :telephone
  validates_uniqueness_of :name, :telephone
end

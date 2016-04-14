class Provider < ActiveRecord::Base
  # Vlida presencia y unicidad al crear mediante el formulario un nuevo proveedor
  has_many :articles
  validates_presence_of :name, :telephone
  validates_uniqueness_of :name, :telephone
end

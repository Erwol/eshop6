class Article < ActiveRecord::Base

  has_and_belongs_to_many :designers
  belongs_to :provider

  validates_length_of :name, :in => 1..255
  validates_presence_of :provider
  validates_presence_of :designers
  validates_presence_of :provided_at
  validates_numericality_of :price
  def designer_names
    self.designers.map{|designer| designer.name}.join(", ")
  end

  def self.latest(num)
    all.order("articles.id desc").includes(:designers, :provider).limit(num)
  end
end

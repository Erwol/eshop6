class Article < ActiveRecord::Base

  has_and_belongs_to_many :designers
  belongs_to :provider

  has_many :cart_items
  has_many :carts, :through => :cart_items

  validates_length_of :title, :in => 1..255
  validates_presence_of :provider
  validates_presence_of :designers
  validates_presence_of :published_at
  validates_numericality_of :page_count, :only_integer => true
  validates_numericality_of :price
  validates_length_of :isbn, :in => 1..13
  validates_format_of :isbn, :with => /[0-9\-xX]{13}/
  validates_uniqueness_of :isbn

  def designer_names
    self.designers.map{|designer| designer.name}.join(", ")
  end

  def self.latest(num)
    all.order("articles.id desc").includes(:designers, :provider).limit(num)
  end
end

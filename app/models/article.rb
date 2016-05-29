class Article < ActiveRecord::Base

  has_and_belongs_to_many :designers
  belongs_to :provider

  has_attached_file :cover_image
  validates_attachment :cover_image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates_length_of :name, :in => 1..255
  validates_presence_of :provider
  validates_presence_of :designers
  validates_presence_of :provided_at
  validates_numericality_of :price
  acts_as_taggable
  def designer_names
    self.designers.map{|designer| designer.name}.join(", ")
  end

  def self.latest(num)
    all.order("articles.id desc").includes(:designers, :provider).limit(num)
  end
end

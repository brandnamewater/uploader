class Listing < ApplicationRecord
  mount_uploader :image, ImageUploader
  serialize :image, JSON # If you use SQLite, add this line.

#  validates attachment content type :image, :content type => /\Aimage\/.*\Z/

  validates :name, :description, :price, presence: true
#  validates :price, numericality: { greater than: 0 }
  validates_presence_of :image

  belongs_to :user
  has_many :orders

  def self.search(search)
    where("name LIKE ?","%#{search}%")
  end

end

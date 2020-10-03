class Property < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true  
  validates :built_type, inclusion: { in: %w(Casa Apartamento Apartaestudio Lote Penthouse Loft Duplex Casafinca)}
  validates :city, length: { maximum: 255 }
=begin
  validates :project, length: { maximum: 255 }
  validates :price, length: { minimum: 6, maximum: 12 }
  validates :address, length: { maximum: 255 }
  validates :apt, length: { maximum: 5 }
  validates :tower, length: { maximum: 20 }
  validates :hood, length: { maximum: 255 }
  
  validates :private_area, length: { maximum: 255 }
  validates :estrato, inclusion: { in: %w(1 2 3 4 5 6 Industrial) }
  validates :beds, length: { maximum: 3 }
  validates :baths, length: { maximum: 3 }
  validates :contact_1, length: { maximum: 255 }
=end
end

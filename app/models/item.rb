class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items
  has_many :order_details

  has_one_attached :image

  def get_image(width,height)
   unless image.attached?
     file_path = Rails.root.join('app/assets/images/default-image.jpeg')
     image.attach(io: File.open(file_path), filename: 'default-image.jpeg', content_type: 'image/jpeg' 'image/webp' )
   end
   image.variant(resize_to_limit: [width,height]).processed
  end

  def add_tax_price
      (self.price * 1.1).round
  end

# Item内の検索機能
  def self.search(keyword)
    where(["name like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])
  end

end

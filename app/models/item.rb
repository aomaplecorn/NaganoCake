class Item < ApplicationRecord

  belongs_to :genre

  has_one_attached :image

  def get_image(width,height)
   unless image.attached?
     file_path = Rails.root.join('app/assets/images/default-image.jpeg')
     image.attach(io: File.open(file_path), filename: 'default-image.jpeg', content_type: 'image/jpeg' )
   end
   image.variant(resize_to_limit: [width,height]).processed
  end

  def add_tax_price
      (self.price * 1.10).round
  end


end

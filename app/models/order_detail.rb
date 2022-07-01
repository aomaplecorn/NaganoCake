class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  # ０＝着手不可, １＝製作待ち, ２＝製作中, ３＝製作完了
  enum making_status: { start_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3 }

  def subtotal
    item.add_tax_price * amount
  end

end

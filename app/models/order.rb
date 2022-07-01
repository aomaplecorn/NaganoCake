class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

  # ０＝クレジットカード、１＝銀行振込
  enum payment_method: { credit_card: 0, transfer: 1 }
  # ０＝入金待ち、１＝入金確認、２＝製作中、３＝発送準備中、４＝発送済み
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }




end

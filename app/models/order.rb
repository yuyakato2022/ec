class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  enum status: { waiting: 0, confirm: 1, production: 2, preparation: 3, sent: 4 }
  enum pay_way: { credit_card: 0, transfer: 1 }


  validates :pay_way, presence: true
  validates :postage, presence: true
  VALID_POSTCODE_REGEX = /\A\d{7}\z/
  validates :postcode, presence: true, format: { with: VALID_POSTCODE_REGEX }
  validates :address, presence: true
  validates :address_name, presence: true
  validates :total_pay, presence: true


  def status_display
    status_i18n
  end

  def payment_method_display
    payment_method_i18n
  end

end

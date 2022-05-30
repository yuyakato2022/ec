class Delivery < ApplicationRecord

  belongs_to :customer

  VALID_POSTCODE_REGEX = /\A\d{7}\z/
  validates :postcode, presence: true, format: { with: VALID_POSTCODE_REGEX }
  validates :address, presence: true
  validates :address_name, presence: true



  def address_display
     '〒' + postcode + ' ' + address + ' ' + address_name
  end
end

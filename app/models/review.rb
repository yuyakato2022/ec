class Review < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  validates :star, presence: true
  validates :title, presence: true
  validates :body, presence: true
  # validates :, presence: true

end

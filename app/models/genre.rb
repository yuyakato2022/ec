class Genre < ApplicationRecord

  has_many :items

  validates :name, uniqueness: true, presence: true

end

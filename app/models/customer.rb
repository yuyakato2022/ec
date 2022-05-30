class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deliveries
  has_many :cart_items
  has_many :orders
  has_many :items, through: :cart_items
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy


  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。' }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。' }
  VALID_POSTCODE_REGEX = /\A\d{7}\z/
  validates :postcode, presence: true, format: { with: VALID_POSTCODE_REGEX }
  validates :address, presence: true
  VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  def full_name
    self.last_name + self.first_name
  end

  def full_address
     '〒' + postcode + ' ' + address
  end

end

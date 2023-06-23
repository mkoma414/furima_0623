class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  KANGI_RENGE = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  KATAKANA_RENGE = /\A[ァ-ヶー－]+\z/.freeze
  validates :password, format: { with: PASSWORD_REGEX }
  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :last_name, format: { with: KANGI_RENGE }
  validates :first_name, presence: true
  validates :first_name, format: { with: KANGI_RENGE }
  validates :last_name_kana, presence: true
  validates :last_name_kana, format: { with: KATAKANA_RENGE }
  validates :first_name_kana, presence: true
  validates :first_name_kana, format: { with: KATAKANA_RENGE }
  validates :birthday, presence: true

  has_many :items
end

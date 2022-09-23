class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :encrypted_password, presence: true, length: {minimum: 6}, format: {with: /\A[a-zA-Z0-9]+\z/ }
  validates :last_name_kanji, presence: true, format: {with: /\A[一-龥]+\z/ }
  validates :first_name_kanji, presence: true, format: {with: /\A[一-龥]+\z/ }
  validates :last_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :birth_id, presence: true, numericality: {other_than: 1}

  has_many :products
  has_many :buys

end

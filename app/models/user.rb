class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :questions, foreign_key: :author
  has_many :answers, foreign_key: :author

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  def author?(resource)
    return true if resource.author == self

    false
  end
end

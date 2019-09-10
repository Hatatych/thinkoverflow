class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'
  validates :title, :body, presence: true

  def best_answer
    answers.best.first
  end
end

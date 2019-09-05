class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'
  validates :body, presence: true

  scope :as_appeared, -> { order(created_at: :desc) }
end

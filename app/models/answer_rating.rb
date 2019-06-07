class AnswerRating < ApplicationRecord
  belongs_to :answer
  belongs_to :interviewer

  scope :exclude_zero, -> { where.not(rating: 0) }
  scope :average_rating, -> {average(:rating).round(2) }
end

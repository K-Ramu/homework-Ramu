require 'test_helper'
require 'byebug'
class CandidateTest < ActiveSupport::TestCase
  def setup
    create_answers_and_ratings
  end

  test "average rating of a candidate's answer to questions - exclude the zero rankings" do
    can = candidates(:barney_rubble)

    answer_ratings = AnswerRating.joins(answer: :candidate).where(candidates: { id: can.id }).exclude_zero
    average = (answer_ratings.pluck(:rating).sum.to_f / answer_ratings.size).round(2)
    
    assert_equal can.answer_ratings.exclude_zero.average_rating, average
  end
end

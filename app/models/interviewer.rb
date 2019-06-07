class Interviewer < ApplicationRecord
  has_many :answer_ratings
  has_many :interview_participants
  has_many :interviews, through: :interview_participants

  scope :schedule, ->(id) { includes(interviews: [:position, :candidate, :questions])
                            .order("interviews.interview_date asc")
                            .where(interviewers: { id: id }) }

  def upcoming_interviews
    {
      interviews: interviews.upcoming(2).map do |interview|
        {
          interview_date: interview.interview_date,
          description: interview.description,
          candidate: {
            name: interview.candidate.try(:name),
            email: interview.candidate.try(:email),
            phone: interview.candidate.try(:phone)
          },
          questions: interview.questions.map(&:question)
        }
      end
    }
  end
end

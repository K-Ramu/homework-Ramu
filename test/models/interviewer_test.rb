require 'test_helper'

class InterviewerTest < ActiveSupport::TestCase
  test "should return the next two interview for upcoming interview schedule" do
    interviewer = interviewers(:hr)
    interviews = interviewer.interviews.order(interview_date: :asc)
    
    assert_includes(Interviewer.schedule(interviewer.id).first.interviews.upcoming, interviews[0])
    assert_includes(Interviewer.schedule(interviewer.id).first.interviews.upcoming(2), interviews[1])

    assert_not_includes(Interviewer.schedule(interviewer.id).first.interviews.upcoming(2), interviews[2])
    assert_not_includes(Interviewer.schedule(interviewer.id).first.interviews.upcoming(2), interviews[3])  
  end

  test "should return candidate information for interviews for upcoming interview schedule" do
    interviewer = interviewers(:hr)
    interview_details = Interviewer.schedule(interviewer.id).first.upcoming_interviews[:interviews]
    assert interview_details.pluck(:candidate).any?
  end

  test "should return list of questions" do
    interviewer = interviewers(:hr)
    interview_details = Interviewer.schedule(interviewer.id).first.upcoming_interviews[:interviews]
    assert interview_details.pluck(:questions).any?
  end
end

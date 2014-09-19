module QuestionsHelper
  def answerer(a)
    return User.find(a.answerer_id)
  end

  def question_user(q)
    return User.find(q.user_id)
  end

  def check_up_vote(q)
    if q.votes.where(votee_id: q.id, user_id: current_user.id, status: 1).exists?
      vote_class = 'btn btn-success disabled'
    else
      vote_class = 'btn btn-success'
    end
    return vote_class
  end

  def check_down_vote(q)
    if q.votes.where(votee_id: q.id, user_id: current_user.id, status: -1).exists?
      vote_class = 'btn btn-danger disabled'
    else
      vote_class = 'btn btn-danger'
    end
    return vote_class
  end

  def count_answer_up(a)
    return a.votes.where(status: 1).count
  end

  def count_answer_down(a)
    return a.votes.where(status: -1).count
  end

  def check_up_vote_answer(q)
    if q.votes.where(votee_id: q.id, user_id: current_user.id, status: 1).exists?
      vote_class = 'btn btn-success disabled'
    else
      vote_class = 'btn btn-success'
    end
    return vote_class
  end

  def check_down_vote_answer(q)
    if q.votes.where(votee_id: q.id, user_id: current_user.id, status: -1).exists?
      vote_class = 'btn btn-danger disabled'
    else
      vote_class = 'btn btn-danger'
    end
    return vote_class
  end
end

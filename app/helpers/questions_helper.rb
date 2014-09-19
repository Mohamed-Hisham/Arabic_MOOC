module QuestionsHelper
  def answerer(a)
    if User.where(id: a.answerer_id).exists?
      return User.find(a.answerer_id)
    else
      return Tutor.find(a.answerer_id)
    end
  end

  def question_user(q)
    return User.find(q.user_id)
  end

  def check_tutor_answer(a)
    return 'answer_border' if answerer(a).class.name == "Tutor"
  end

  def check_up_vote(q)
    if q.votes.where(votee_id: q.id, voter_id: current_user.id, status: 1).exists?
      vote_class = 'btn btn-success disabled'
    else
      vote_class = 'btn btn-success'
    end
    return vote_class
  end

  def check_down_vote(q)
    if q.votes.where(votee_id: q.id, voter_id: current_user.id, status: -1).exists?
      vote_class = 'btn btn-danger disabled'
    else
      vote_class = 'btn btn-danger'
    end
    return vote_class
  end

  def check_tutor_up_vote(q)
    if q.votes.where(votee_id: q.id, voter_id: current_tutor.id, status: 1).exists?
      vote_class = 'btn btn-success disabled'
    else
      vote_class = 'btn btn-success'
    end
    return vote_class
  end

  def check_tutor_down_vote(q)
    if q.votes.where(votee_id: q.id, voter_id: current_tutor.id, status: -1).exists?
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
    if q.votes.where(votee_id: q.id, voter_id: current_user.id, status: 1).exists?
      vote_class = 'btn btn-success disabled'
    else
      vote_class = 'btn btn-success'
    end
    return vote_class
  end

  def check_down_vote_answer(q)
    if q.votes.where(votee_id: q.id, voter_id: current_user.id, status: -1).exists?
      vote_class = 'btn btn-danger disabled'
    else
      vote_class = 'btn btn-danger'
    end
    return vote_class
  end

  def check_tutor_up_vote_answer(q)
    if q.votes.where(votee_id: q.id, voter_id: current_tutor.id, status: 1).exists?
      vote_class = 'btn btn-success disabled'
    else
      vote_class = 'btn btn-success'
    end
    return vote_class
  end

  def check_tutor_down_vote_answer(q)
    if q.votes.where(votee_id: q.id, voter_id: current_tutor.id, status: -1).exists?
      vote_class = 'btn btn-danger disabled'
    else
      vote_class = 'btn btn-danger'
    end
    return vote_class
  end
end

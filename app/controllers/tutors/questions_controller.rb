class Tutors::QuestionsController < TutorsController
  before_action :set_question, only: [:show, :edit, :update, :request_to_delete, :question_vote]
  before_action :set_course

  # GET /questions
  # GET /questions.json
  def index
    @questions = @course.questions.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answers = @question.answers.order_by(:overall_votes.desc)
    @question_upvotes = @question.votes.where(status: 1).count
    @question_downvotes = @question.votes.where(status: -1).count
  end

  def question_vote
    new_vote = @question.votes.find_or_create_by(voter: current_tutor, votee: @question, votee_class: "Question", voter_class: "Tutor")
    if params[:question_vote] == "1"
      new_vote.vote_up
      flash[:notice] = "Successfully voted up"
    elsif params[:question_vote] == "-1"
      new_vote.vote_down
      flash[:notice] = "Successfully voted down"
    else
      flash[:alert] = "Illegal vote"
    end

    respond_to do |format|
      format.html {redirect_to tutor_course_question_path(@tutor, @course, @question)}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params[:question].permit(:title, :description)
    end
    def vote_params
      params.permit(:question_vote)
    end
end

class User::QuestionsController < UsersController
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
    @answers = @question.answers.all.to_a
    @question_upvotes = @question.votes.where(status: 1).count
    @question_downvotes = @question.votes.where(status: -1).count
  end

  # GET /questions/new
  def new
    @question = @course.questions.new
  end


  # POST /questions
  # POST /questions.json
  def create
    @question = @course.questions.new(question_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
        format.html { redirect_to user_course_question_path(@course, @question), notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /questions/1
  # POST /questions/1.json
  def request_to_delete
    @question.request_delete
    respond_to do |format|
      if @question.save
        format.html { redirect_to user_course_question_path(@course, @question), notice: 'Question is sent to admin for reviewing.' }
      else
        format.html { redirect_to questions_url, notice: 'Question can not be deleted.' }
      end
    end
  end

  def question_vote
    new_vote = @question.votes.find_or_create_by(user: current_user, votee: @question, votee_class: "Question")

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
      format.html {redirect_to user_course_question_path(@course, @question)}
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

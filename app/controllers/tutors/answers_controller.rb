class Tutors::AnswersController < TutorsController
  before_action :set_answer, except: :create
  before_action :set_question
  before_action :set_course

  # POST /questions
  # POST /questions.json
  def create
    @answer = @question.answers.new(answer_params)
    @answer.answerer = current_tutor

    respond_to do |format|
      if @answer.save
        format.html { redirect_to tutor_course_question_path(@tutor, @course, @question), notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      if @answer.save
        format.html { redirect_to tutor_course_question_path(@tutor, @course, @question), notice: 'Question is sent to admin for reviewing.' }
      else
        format.html { redirect_to questions_url, notice: 'Answer can not be deleted.' }
      end
    end
  end

  def answer_vote
    answer_vote_found = @answer.votes.where(voter: @tutor, votee: @answer, votee_class: "Answer", voter_class: "Tutor")
    unless answer_vote_found.exists?
      new_answer_vote = @answer.votes.where(voter: @tutor, votee: @answer, votee_class: "Answer", voter_class: "Tutor").create
    else
      new_answer_vote = @answer.votes.find_by(voter: @tutor, votee: @answer, votee_class: "Answer", voter_class: "Tutor")
    end

    if params[:answer_vote] == "1"
      new_answer_vote.vote_up
      flash[:notice] = "Answer voted up"
    elsif params[:answer_vote] == "-1"
      new_answer_vote.vote_down
      flash[:notice] = "Answer voted down"
    else
      flash[:alert] = "Illegal vote"
    end

    respond_to do |format|
      format.html {redirect_to tutor_course_question_path(@tutor, @course, @question)}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params[:answer].permit(:description)
    end
    def vote_params
      params.permit(:answer_vote)
    end
end

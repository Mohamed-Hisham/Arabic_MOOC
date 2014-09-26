class Admin::AnswersController < AdminsController
  before_filter :get_answer, only: :destroy
  before_filter :get_question
  before_filter :get_course

  def index
    @answers = @question.answers.all.to_a
  end

  def destroy
    respond_to do |format|
      if @answer.destroy
        format.html {redirect_to admin_course_question_answers_path(@course, @question), notice: "Answer was successfully deleted."}
      else
        format.html {redirect_to admin_course_question_answers_path(@course, @question), alert: "Answer was not deleted. Please Try again later."}
      end
    end
  end

  private

  def get_answer
    @answer = Answer.find(params[:id])
  end

  def get_question
    @question = Question.find(params[:question_id])
  end

  def get_course
    @course = Course.find(params[:course_id])
  end
end

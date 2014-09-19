class Admin::QuestionsController < AdminsController
  before_action :set_question, only: :destroy
  before_action :set_course

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy

    respond_to do |format|
      if @question.save
        format.html { redirect_to admin_course_path(@course), notice: 'Question was successfully deleted.' }
      else
        format.html { redirect_to admin_course_path(@course), notice: 'Question was not be deleted. Please try again later.' }
      end
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
end

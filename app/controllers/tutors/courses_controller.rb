class Tutors::CoursesController < TutorsController
  before_action :set_course, only: :show

  # GET /courses
  # GET /courses.json
  def index
    @courses = @tutor.courses.all.to_a
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @sections = @course.sections.all.to_a
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = @tutor.courses.find(params[:id])
    end
end

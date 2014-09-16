class User::CoursesController < UsersController
  before_action :set_course, only: [:show, :rate_course]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all.to_a
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @sections = @course.sections.all.to_a
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end
end

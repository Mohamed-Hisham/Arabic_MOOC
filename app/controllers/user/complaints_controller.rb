class User::ComplaintsController < UsersController
  before_action :set_video
  before_action :set_section
  before_action :set_course

  def create
    @complaint = current_user.complaints.new(complaint_param)

    respond_to do |format|
      if @complaint.save
        @complaint.user = current_user
        format.html {redirect_to user_course_section_video_path(@course, @section, @video), notice: "Your feedback was sent to the Administrator. It will be checked soon."}
      else
        format.html {redirect_to user_course_section_video_path(@course, @section, @video), alert: "There was a problem submitting your feedback to the Administrator. Please try again later."}
      end
    end
  end

  private
  def complaint_param
    params[:complaint].permit(:title, :description)
  end

  def view_param
    params.permit(:course_id, :section_id, :video_id)
  end

  def set_video
    @video = Video.find(params[:video_id])
  end

  def set_section
    @section = Section.find(params[:section_id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
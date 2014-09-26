class User::VideosController < UsersController
  before_action :set_video
  before_action :set_section
  before_action :set_course

  # GET /videos/1
  # GET /videos/1.json
  def show
    @first_video = @course.sections.first.videos.first
    @sections = @course.sections.all.to_a
    @user_notes = @video.notes.where(author: @user).to_a
    @tutor_notes = @video.notes.where(author: @course.tutor).to_a
    @notes = @user_notes.concat(@tutor_notes)
    @note = @video.notes.new
    @synmark = @note.synmarks.new
    check_view_token
  end

  def export_tutor
    @tutor_notes = @video.notes.where(author: @course.tutor).to_a
  end

  def rate_course
    @course.rate_number(params[:rating_number], current_user)
    respond_to do |format|
      if @course.save
        format.html {redirect_to user_course_section_video_path(@course, @section, @video), notice: "Course was successfully rated"}
      else
        format.html {redirect_to user_course_section_video_path(@course, @section, @video), alert: "Course was not rated"}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    def set_section
      @section = Section.find(params[:section_id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def course_params
      params.permit(:rating_number)
    end

    protected
    def generate_view_token
      to_be_enc = "#{current_user.id} #{@course.id} #{@section.id}"
      token = AES.encrypt(to_be_enc, Rails.application.secrets.secret_key_base)
      return token
    end

    def generate_video_token
      to_be_enc = "#{current_user.id} #{@course.id} #{@section.id} #{@video.id}"
      token = AES.encrypt(to_be_enc, Rails.application.secrets.secret_key_base)
      return token
    end

    def check_view_token
      check_viewing_same_video
      if session[:view_token] == nil && session[:video_token] == nil
        session[:view_token] = generate_view_token
        session[:video_token] = generate_video_token
        @video.inc_views
      elsif session[:view_token] != nil && session[:video_token] == nil
        session[:video_token] = generate_video_token
        @video.inc_views
      end
    end

    def check_viewing_same_video
      unless session[:old_video] == @video.id
        session[:video_token] = nil
      end
      session[:old_video] = @video.id
    end
end

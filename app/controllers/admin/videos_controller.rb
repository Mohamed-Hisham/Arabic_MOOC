class Admin::VideosController < AdminsController
  before_action :set_admin_video, only: [:show, :edit, :update, :destroy, :guest_can_view]
  before_action :get_course
  before_action :get_section

  # GET /admin/videos/1
  # GET /admin/videos/1.json
  def show
  end

  # GET /admin/videos/new
  def new
    @video = @section.videos.new
  end

  # GET /admin/videos/1/edit
  def edit
  end

  # POST /admin/videos
  # POST /admin/videos.json
  def create
    @video = @section.videos.new(admin_video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to admin_course_section_video_path(@course, @section, @video), notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/videos/1
  # PATCH/PUT /admin/videos/1.json
  def update
    respond_to do |format|
      if @video.update(admin_video_params)
        format.html { redirect_to admin_course_section_video_path(@course, @section, @video), notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/videos/1
  # DELETE /admin/videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to admin_videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def guest_can_view
    @video.viewed_by_guest_status(params[:video][:viewed_by_guest]) unless params[:video].nil?
    @video.viewed_by_guest_status(false) if params[:video].nil?
    respond_to do |format|
      if @video.save
        format.html { redirect_to admin_course_section_video_path(@course, @section, @video), notice: 'Video was successfully enabled for guest viewing.' }
      else
        format.html { redirect_to admin_course_section_video_path(@course, @section, @video), alert: 'There was a problem when enabling a video for guests.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_video
      @video = Video.find(params[:id])
    end

    def get_section
      @section = Section.find(params[:section_id])
    end

    def get_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_video_params
      params[:video].permit(:title, :video_file)
    end
end

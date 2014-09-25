class User::NotesController < UsersController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :get_video
  before_action :get_section
  before_action :get_course

  # GET /notes
  # GET /notes.json
  def index
    @notes = @video.notes.all
  end

  # GET /notes/new
  def new
    @note = @video.notes.new
    @synmark = @note.synmarks.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = @video.notes.new(note_params)
    @note.author = current_user
    @note.author_type = "User"

    respond_to do |format|
      if @note.save
        synmark_time_attributes
        @synmark = @note.synmarks.create(start_time: @starttime, end_time: @endtime)
        format.html { redirect_to user_course_section_video_path(@course, @section, @video), notice: 'Note was successfully created.' }
      else
        format.html { redirect_to user_course_section_video_path(@course, @section, @video), alert: "Note was not created. Check again" }
      end
    end
  end

  def synmark_time_attributes
    @starttime = params[:note][:from_min].to_i*60 + params[:note][:from_sec].to_i
    @endtime = params[:note][:to_min].to_i*60 + params[:note][:to_sec].to_i

    # return starttime, endtime
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to user_course_section_video_path(@course, @section, @video), notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    def get_video
      @video = Video.find(params[:video_id])
    end

    def get_section
      @section = Section.find(params[:section_id])
    end

    def get_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params[:note].permit(:title, :description)
    end

    def synmark_params
      params[:note].permit(:from_min, :from_sec, :to_min, :to_sec)
    end
end

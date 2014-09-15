class VideosController < ApplicationController
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
end

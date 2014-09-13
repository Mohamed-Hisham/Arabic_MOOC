module CoursesHelper

  def first_section(course)
    @first_section = course.sections.first
  end

  def first_video(course)
    return course.sections.first.videos.first
  end
end

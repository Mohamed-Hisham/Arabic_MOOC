class CoursesController < ApplicationController
  def index
    @courses = Course.all.to_a
  end
end

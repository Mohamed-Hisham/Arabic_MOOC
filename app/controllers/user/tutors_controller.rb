class User::TutorsController < UsersController
  before_filter :find_model

  def show
  end

  def rate_tutor
    @tutor.rate_number(params[:rating_number], current_user)
    respond_to do |format|
      if @tutor.save
        format.html {redirect_to user_tutor_path(@tutor), notice: "Tutor was successfully rated"}
      else
        format.html {redirect_to user_tutor_path(@tutor), alert: "Tutor was not rated"}
      end
    end
  end

  private
  def find_model
    @tutor = Tutor.find(params[:id]) if params[:id]
  end

  def course_params
    params.permit(:rating_number)
  end
end
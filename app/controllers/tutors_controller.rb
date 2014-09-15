class TutorsController < ApplicationController
  before_action :authenticate_tutor!
  before_action :set_tutor

  def show
  end

  # GET /tutors/1/edit
  def edit
  end

  def update
    respond_to do |format|
      if @tutor.update(tutor_params)
        format.html { redirect_to @tutor, notice: 'Tutor was successfully updated.' }
        format.json { render :show, status: :ok, location: @tutor }
      else
        format.html { render :edit }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @tutor.destroy
  #   respond_to do |format|
  #     format.html { redirect_to tutors_url, notice: 'Tutor was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutor
      @tutor = current_tutor
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutor_params
      params[:tutor].permit(:email, :password, :password_confirmation, :first_name, :last_name, :user_name, :work_place, :phone_number, :dob, :gender, :about_me, :interest, :occupation, :avatar)
    end
end

class Admin::ComplaintsController < AdminsController

  def index
    @complaints = Complaint.all.to_a
  end

end
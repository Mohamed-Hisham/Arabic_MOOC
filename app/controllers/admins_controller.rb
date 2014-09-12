class AdminsController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :find_model
  layout "admin"

  def show
  end

  private
  def find_model
    @admin = current_admin
  end
end
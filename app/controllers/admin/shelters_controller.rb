# app/controllers/admin/shelters_controller

class Admin::SheltersController < ApplicationController 
  # before_action  :require_admin
  def index
    @shelters = Shelter.order_by_reverse_alphabetical
    @pending = Shelter.order_alphabetically.has_pending_applications
  end

  def show
    shelter = Shelter.find(params[:id])
    @shelter_details = shelter.find_name_and_city
    @average_age = Pet.average_age_of_all
  end

  # def require_admin 
  #   unless current_user.admin?
  #     redirect_to "/shelters"
  #   end
  # end
end
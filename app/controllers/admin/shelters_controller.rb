# app/controllers/admin/shelters_controller

class Admin::SheltersController < ApplicationController 
  def index
    @shelters = Shelter.order_by_reverse_alphabetical
    @pending = Shelter.order_alphabetically.has_pending_applications
  end

  def show
    shelter = Shelter.find(params[:id])
    @shelter_details = shelter.find_name_and_city
    @average_age = Pet.average_age_of_all
    @adoptable_pets = Pet.adoptable.count
    @adopted_pets = shelter.adopted_pets_count
  end
end
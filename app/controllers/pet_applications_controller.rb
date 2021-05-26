# app/controllers/pet_applications_controller

class PetApplicationsController < ApplicationController

  def add_pet
    application = Application.find(params[:applications_id])
    pet = Pet.find(params[:pet_id])
    PetApplication.create(pet: pet, application: application)
    redirect_to "/applications/#{application.id}"
  end

  def update_status
    @application = Application.find(params[:application_id])
    pet_app = PetApplication.find_application(params[:pet_id], params[:application_id])
    pets = PetApplication.find_pets(params[:pet_id], params[:application_id])
    pet_app.update(:status => params[:status_update])
    
    if @application.all_pets_accepted?
      pets.each do |pet|
        pet.toggle_adoptable_status
      end
      @application.update(status: "Approved")
    end

    redirect_to "/admin/applications/#{@application.id}"
  end
end
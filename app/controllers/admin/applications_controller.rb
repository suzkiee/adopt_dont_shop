# app/controllers/admin/application_controller

class Admin::ApplicationsController < ApplicationController 
  def show 
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_app = @application.pet_applications
  end
end
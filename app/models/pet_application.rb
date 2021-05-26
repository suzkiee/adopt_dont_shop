class PetApplication < ApplicationRecord 
  belongs_to :pet
  belongs_to :application

  def self.find_application(pet_id, app_id)
    pet_app = where("pet_id = #{pet_id} and application_id = #{app_id}")
    pet_app.first.application
  end
end
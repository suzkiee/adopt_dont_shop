class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications, dependent: :destroy

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true

  def all_pets_accepted?
    pet_applications.all? do |app|
      app.status == "Accepted"
    end
  end

  def any_pets_rejected?
    pet_applications.any? do |app|
      app.status == "Rejected"
    end
  end

  def pending_pet_apps 
    pet_applications.find_all do |app|
      app.status == "Pending"
    end
  end

  def pending_pets 
    pet_apps = pending_pet_apps 
    pets = pet_apps.flat_map do |app|
      app.application.pets
    end 
    pets.uniq
  end
end

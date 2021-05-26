# spec/models/pet_application_spec
require 'rails_helper'

RSpec.describe PetApplication, type: :model do

  describe 'relationships' do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe '::class methods' do
    it '::find_application' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      app = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "Pending")
      pet_app = PetApplication.create!(pet: pet, application: app)

      expect(PetApplication.find_application(pet.id, app.id)).to eq(pet_app)
    end
  end
end
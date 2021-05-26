# spec/models/application_spec
require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_numericality_of(:zip_code) }
  end

  describe '#instance methods' do
    it '#all_pets_accepted?' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 4, breed: 'whippet', name: 'May', shelter_id: shelter.id)
      app = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "Pending")
      pet_app_1 = PetApplication.create!(pet: pet_2, application: app, status: "Accepted")
      pet_app_2 = PetApplication.create!(pet: pet_2, application: app, status: "Accepted")

      expect(app.all_pets_accepted?).to eq(true)            
    end

    it '#any_pets_rejected?' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 4, breed: 'whippet', name: 'May', shelter_id: shelter.id)
      app = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "Pending")
      pet_app_1 = PetApplication.create!(pet: pet_2, application: app, status: "Rejected")
      pet_app_2 = PetApplication.create!(pet: pet_2, application: app, status: "Accepted")

      expect(app.any_pets_rejected?).to eq(true)            
    end
  end  
end

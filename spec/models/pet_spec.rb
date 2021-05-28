#spec/models/pet_spec
require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many(:pet_applications) }
    it { should have_many(:applications).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 4, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  end

  describe 'class methods' do
    describe '::search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '::adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end

    describe '::partial_search' do
      it 'returns partial matches' do
        expect(Pet.search("Cla")).to eq([@pet_2])
      end
    end

    describe '::average_age_of_all' do
      it 'returns average age of all pets' do
        expect(Pet.average_age_of_all).to eq(4)
      end
    end

    describe '::toggle_accepted_pets' do
      it 'toggles accepted pets adoptable boolean to opposite status' do
        app = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "Pending")
        pet_app_1 = PetApplication.create!(pet: @pet_1, application: app, status: "Accepted")
        pet_app_2 = PetApplication.create!(pet: @pet_3, application: app, status: "Accepted")
        
        expect(@pet_1.adoptable).to be(true)
        expect(@pet_3.adoptable).to be(false)

        Pet.toggle_accepted_pets
   
        expect(Pet.all[1].adoptable).to be(false)
        expect(Pet.all[2].adoptable).to be(true)
      end
    end
  end

  describe 'instance methods' do
    describe '#shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
    
    describe '#toggle_adoptable_status' do
      it 'toggles current adoptable boolean to opposite status' do
        expect(@pet_1.adoptable).to be(true)
        expect(@pet_3.adoptable).to be(false)
        
        @pet_1.toggle_adoptable_status
        @pet_3.toggle_adoptable_status

        expect(@pet_1.adoptable).to be(false)
        expect(@pet_3.adoptable).to be(true)
      end
    end
  end
end

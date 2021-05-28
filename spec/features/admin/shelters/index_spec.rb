require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  end

  it 'shows all shelters in reverse alphabetical order' do
    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_2.name).to appear_before(@shelter_1.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it 'links to shelter show page' do
    pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_3.id)
    pet_2 = @shelter_1.pets.create!(adoptable: true, age: 4, breed: 'dingo', name: 'Maxy', shelter_id: @shelter_2.id)
    app_1 = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "Pending" )
    app_2 = Application.create!(name: "Max Bob", street_address: "123 Play Street", city: "Meford", state: "Masachusetts", zip_code: 02155, description: "none", status: "Pending" )
    PetApplication.create!(pet: pet_1, application: app_1) 
    PetApplication.create!(pet: pet_2, application: app_2) 
    
    visit "/admin/shelters"
  
    click_on("Aurora shelter")
    expect(current_path).to eq("/admin/shelters/#{@shelter_1.id}")
  end

  it 'lists shelters with pending applications alphabetically' do
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_3.id)
    pet_2 = Pet.create!(adoptable: true, age: 4, breed: 'dingo', name: 'Maxy', shelter_id: @shelter_2.id)
    app_1 = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "Pending" )
    app_2 = Application.create!(name: "Max Bob", street_address: "123 Play Street", city: "Meford", state: "Masachusetts", zip_code: 02155, description: "none", status: "Pending" )
    PetApplication.create!(pet: pet_1, application: app_1) 
    PetApplication.create!(pet: pet_2, application: app_2) 
    
    visit "/admin/shelters"

    within(".statistics") do
      expect(@shelter_3.name).to appear_before(@shelter_2.name)
    end
  end
end
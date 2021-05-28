# spec/features/admin/show_spec

require 'rails_helper'

RSpec.describe 'the admin shelter show page' do
  before(:each) do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
  end

  it 'shows shelter and its attributes' do
    visit "/admin/shelters/#{@shelter.id}"
  
    expect(page).to have_content(@shelter.name)
    expect(page).to have_content(@shelter.city)
  end

  it 'shows statistics of shelter' do

    visit "/admin/shelters/#{@shelter.id}"

    expect(page).to have_content("Statistics")
    expect(page).to have_content("Average Age of All Pets: 2")
    expect(page).to have_content("Number of Adoptable Pets: 2")
  end

  it 'shows statistics of shelter' do
    visit "/admin/shelters/#{@shelter.id}"

    expect(page).to have_content("Statistics")
    expect(page).to have_content("Average Age of All Pets: 2")
    expect(page).to have_content("Number of Adoptable Pets: 2")
  end

  it 'shows number of pets that have been adopted from this shelter' do
    app = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "Pending")
    PetApplication.create!(pet: @pet_1, application: app, status: "Accepted")
    visit "/admin/shelters/#{@shelter.id}"
    
    expect(page).to have_content("Number of Pets Adopted: 1")
  end

  it 'lists links to pets that are still pending' do
    app = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "Pending" )
    pet_app = PetApplication.create!(pet: @pet_1, application: app, status: "Pending")
    
    visit "/admin/shelters/#{@shelter.id}"

    expect(page).to have_content("Action Required")
    expect(page).to have_link("Lucille Bald")
    
    click_on("Lucille Bald")

    expect(current_path).to eq("/admin/applications/#{app.id}")
  end
end 
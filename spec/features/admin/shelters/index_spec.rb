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
    visit "/admin/shelters"
  
    click_on("Aurora shelter")
    expect(current_path).to eq("/admin/shelters/#{@shelter_1.id}")
  end

  it 'lists shelters with pending applications;' do
    visit "/admin/shelters"
    pet = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    app = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "In Progress" )
    pet.applications << app 
    @shelter_1.pets << pet

    expect(page).to have_content(@shelter_1.name)
  end
end
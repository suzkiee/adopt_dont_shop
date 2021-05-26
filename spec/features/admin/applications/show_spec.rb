# spec/features/admin/show_spec
require 'rails_helper'

RSpec.describe 'the admin applications page'do
  before(:each) do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
    @app = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "Pending")
    PetApplication.create!(pet: @pet_1, application: @app)
    PetApplication.create!(pet: @pet_2, application: @app)
    PetApplication.create!(pet: @pet_3, application: @app)
  end

  it 'shows pets on application' do
    visit "/admin/applications/#{@app.id}"
    
    expect(page).to have_button("Approve")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_3.name)
  end

  it 'can approve application to certain pet' do
    visit "/admin/applications/#{@app.id}"

    expect(page).to have_content("Pending")

    first(".row").click_on "Approve"

    expect(page).to have_content("Accepted")
  end

  it 'can reject application to certain pet' do
    visit "/admin/applications/#{@app.id}"

    expect(page).to have_content("Pending")

    first(".row").click_on "Reject"

    expect(page).to have_content("Rejected")
  end
end
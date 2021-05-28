# spec/features/admin/applications/show_spec
require 'rails_helper'

RSpec.describe 'the admin applications page'do
  before(:each) do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @app = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "none", status: "Pending")
    @app_2 = Application.create!(name: "Max Wannae", street_address: "123 Here Road", city: "Liliput", state: "Missouri", zip_code: 00000, description: "none", status: "Pending")
    @pet_app = PetApplication.create!(pet: @pet_1, application: @app)  
  end

  it "shows the application and all its attributes" do
    visit "/admin/applications/#{@app.id}"

    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app.street_address)
    expect(page).to have_content(@app.city)
    expect(page).to have_content(@app.state)
    expect(page).to have_content(@app.zip_code)
    expect(page).to have_content(@app.status)
  end

  it 'shows pets on application' do
    visit "/admin/applications/#{@app.id}"
    
    expect(page).to have_button("Approve")
    expect(page).to have_content(@pet_1.name)
  end

  it 'can approve application to certain pet' do
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    PetApplication.create!(pet: pet_2, application: @app)

    visit "/admin/applications/#{@app.id}"

    expect(page).to have_content("Pending")

    first(:button, "Approve").click

    expect(page).to have_content("Accepted")
  end

  it 'can reject application to certain pet' do
    visit "/admin/applications/#{@app.id}"

    expect(page).to have_content("Pending")

    first(".pets_info").click_on "Reject"

    expect(page).to have_content("Rejected")
  end

  it "changes application status to 'Approved' when all pets are approved" do
    visit "/admin/applications/#{@app.id}"

    expect(page).to have_content("Pending")
    
    click_on("Approve")

    expect(page).to have_content("Adopted")
    expect(page).to have_content("Approved")
  end

  it "changes application status to 'Rejected' when one or more pets are rejected" do
    visit "/admin/applications/#{@app.id}"

    expect(page).to have_content("Pending")
    
    click_on("Reject")
   
    within('.application') do
      expect(page).to have_content("Rejected")
    end
  end
  
  it 'displays message for adopted pet on other pending applications' do
    visit "/admin/applications/#{@app.id}"

    expect(page).to have_content("#{@pet_1.name}")

    click_on('Approve')

    expect(page).to have_content("Adopted")
  end
end
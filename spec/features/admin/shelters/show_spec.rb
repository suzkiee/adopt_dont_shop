# spec/features/admin/show_spec

require 'rails_helper'

RSpec.describe 'the admin show' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  end

  it 'shows shelter and its attributes' do
    visit "/admin/shelters/#{@shelter.id}"
  
    expect(page).to have_content(@shelter.name)
    expect(page).to have_content(@shelter.city)
  end

  it 'shows statistics of shelter' do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)

    visit "/admin/shelters/#{@shelter.id}"

    expect(page).to have_content("Statistics")
    expect(page).to have_content("Average Age of All Pets: 2")
    expect(page).to have_content("Number of Adoptable Pets: 2")
  end
end 
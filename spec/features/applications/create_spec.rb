require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'the application new' do
    it 'renders the new form' do
      visit '/applications/new'

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application' do
        visit '/applications/new'

        fill_in 'Name', with: 'Suzie Kim'
        fill_in 'Street Address', with: "123 State Street"
        fill_in 'City', with: 'Boston'
        fill_in 'State', with: 'Massachusetts'
        fill_in 'Zip code', with: "02115"
       
        click_button 'Submit'
        
        expect(page).to have_content("Suzie Kim")
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit '/applications/new'
       
        fill_in 'City', with: 'Houston'
        click_button 'Submit'
  
        expect(page).to have_current_path('/applications/new')
        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, State can't be blank, Zip code can't be blank, Zip code is not a number")
      end
    end
  end
end

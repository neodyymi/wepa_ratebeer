require 'rails_helper'

include OwnTestHelper

describe "User" do
  before :each do
    FactoryGirl.create :user
    FactoryGirl.create :brewery
    sign_in(username:"Pekka", password:"Foobar1")
  end

  describe "when adding a valid beer" do
    it "it is added to database" do
      visit new_beer_path

      fill_in('beer[name]', with:'Testiolut' )
      select('Weizen', from:'beer[style]')
      select('anonymous', from:'beer[brewery_id]')

      expect{
        click_button "Create Beer"
      }.to change{Beer.count}.by(1)
    end
    it "is not added if a invalid valid name given" do
      visit new_beer_path
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(0)
      expect(current_path).to eq(beers_path)
      expect(page).to have_content "New Beer"
      expect(page).to have_content "Name can't be blank"
    end

  end
end
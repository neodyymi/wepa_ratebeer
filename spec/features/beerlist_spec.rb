require 'rails_helper'

describe "Beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end
  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name:"Koff")
    @brewery2 = FactoryGirl.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name:"Ayinger")
    @style1 = Style.create style:"Lager"
    @style2 = Style.create style:"Rauchbier"
    @style3 = Style.create style:"Weizen"
    @beer1 = FactoryGirl.create(:beer, name:"Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryGirl.create(:beer, name:"Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryGirl.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows the known beers", js:true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "shows a known beer", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end

  it "shows content in order", :js => true do
    visit beerlist_path
    expect(find('table').find('tr:nth-child(2)')).to have_content "Fastenbier"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Lechte"
  end
  it "sorts into correct order when clicking on style", :js => true do
    visit beerlist_path
    click_link('Style')
    expect(find('table').find('tr:nth-child(2)')).to have_content "Nikolai"
  end
  it "sorts into correct order when clicking on brewery", :js => true do
    visit beerlist_path
    click_link('Brewery')
    expect(find('table').find('tr:nth-child(2)')).to have_content "Lechte"
  end
end

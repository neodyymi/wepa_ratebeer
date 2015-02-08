require 'rails_helper'

describe Beer do

  describe "with proper name and style" do
    let!(:beer){Beer.create name:"testi", style:"ipa"}
    it "should be valid" do
      expect(beer).to be_valid
    end
    it "should be saved" do
      expect(Beer.find_by name:"testi", style:"ipa").to be_valid
    end
  end
  describe "should not be created without" do
    it "a name" do
      b = Beer.create name:"", style:"ipa"
      expect(b).not_to be_valid
    end
    it "a style" do
      b = Beer.create name:"testi", style:""
      expect(b).not_to be_valid
    end
  end
end

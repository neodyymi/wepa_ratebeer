require 'rails_helper'

describe Beer do

  describe "with proper name and style" do
    let!(:style){Style.create style:'ipa', description:'jotain paskaa'}
    let!(:beer){Beer.create name:"testi", style:style}
    it "should be valid" do
      expect(beer).to be_valid
    end
    it "should be saved" do
      expect(Beer.find_by name:"testi", style:style).to be_valid
    end
  end
  describe "should not be created without" do
    it "a name" do
      st = Style.create style:'ipa', description:'jotain paskaa'
      b = Beer.create name:"", style:st
      expect(b).not_to be_valid
    end
    it "a style" do
      b = Beer.create name:"testi", style:nil
      expect(b).not_to be_valid
    end
  end
end

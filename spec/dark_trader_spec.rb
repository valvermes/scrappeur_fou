require_relative '../lib/dark_trader.rb'

describe "trader method" do
    it "should return an array" do
      expect(trader).to be_instance_of Array
    end
    it "should not be nil" do 
        expect(trader).not_to be_nil
    end
  
  end
  
  #
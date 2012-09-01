require 'spec_helper'

describe CentralBankOfRussia do
  describe "#update_rates" do
    before do
      subject.stub(:open)
      subject.stub(:parse_rates => {"USD" => 30.5})
      subject.update_rates
    end

    it "should convert currencies" do
      subject.exchange_with("2 USD".to_money, "RUB").should == "61 RUB".to_money
    end

    it "should convert currencies both ways" do
      subject.exchange_with("30 RUB".to_money, "USD").should == "0.98 USD".to_money
    end
  end

  describe "#parse_rates" do
    let(:doc) { File.read('spec/fixtures/cbr_response.xml') }

    it "should parse ordinary currencies" do
      subject.send(:parse_rates, doc).should include("EUR" => 40.7249)
    end

    it "should correctly interpret nominals other than 1" do
      subject.send(:parse_rates, doc).should include("KZT"=>0.21762)
    end
  end
end

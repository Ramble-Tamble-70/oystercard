require './lib/oystercard.rb'

describe Oystercard do
  it "initializes with a balance of 0" do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end
end
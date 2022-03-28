require './lib/oystercard.rb'

describe Oystercard do
  it "initializes with a balance of 0" do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  it "tops up up money when given" do
    money = rand(300)
    card = Oystercard.new
    card.top_up(money)
    expect(card.balance).to eq money
  end
end
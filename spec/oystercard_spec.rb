require './lib/oystercard'

describe Oystercard do
  it 'initializes with a balance of 0' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  it 'tops up up money when given' do
    card = Oystercard.new
    money = rand(card.limit)
    card.top_up(money)
    expect(card.balance).to eq money
  end

  it 'will not allow topping that would exceed its limit of £90' do
    card = Oystercard.new
    card.top_up(card.limit)
    expect{ card.top_up(1) }.to raise_error("Cannot top-up. Would exceed #{card.limit}")
  end

  it 'will deduct fare from balance when requested' do
    expect{ subject.deduct(5) }.to change{ subject.balance }.by(-5)
  end
end

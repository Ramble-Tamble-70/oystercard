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

  it '#touch_in - Change @card_status variable to in use' do
    subject.top_up(1)
    expect(subject.touch_in).to eq("in use")
  end

  it '#touch_out - Change @card_status variable to not in use' do
    expect(subject.touch_out).to eq("not in use")
  end

  it '#in_journey? - To provide a true value' do
    subject.top_up(1)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'raise error if card less than minimum amount' do
    expect { subject.touch_in }.to raise_error("insufficient funds, less than #{@MINIMUM_FARE}")
  end
end

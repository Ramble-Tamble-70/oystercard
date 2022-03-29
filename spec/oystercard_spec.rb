require './lib/oystercard'

describe Oystercard do

  let(:station) { double :station }

  it 'initializes with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'tops up up money when given' do
    money = rand(subject.limit)
    subject.top_up(money)
    expect(subject.balance).to eq money
  end

  it 'will not allow topping that would exceed its limit of £90' do
    subject.top_up(subject.limit)
    expect{ subject.top_up(1) }.to raise_error("Cannot top-up. Would exceed #{subject.limit}")
  end

  it '#in_journey? - To provide a true value' do
    subject.top_up(1)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  it 'raise error if card less than minimum amount' do
    expect { subject.touch_in(station) }.to raise_error("insufficient funds, less than #{@MINIMUM_FARE}")
  end

  it '#touch_out - Checks @balance has been reduced by minimum fare' do
    subject.top_up(10)
    subject.touch_in(station)
    expect { subject.touch_out(station) }.to change { subject.balance }.by(-1)
  end

  it 'touch_in changes entry station' do
    subject.top_up(10)
    subject.touch_in(station)
    expect(subject).to have_attributes(:entry_station => station)
  end

  it '#list_of_journeys is empty by default' do
    expect(subject.list_of_journeys).to be_empty
  end

  it '#touch_out changes @exit_station' do
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject).to have_attributes(:exit_station => station)
  end

  it '#touch_in and #touch_out creates one journey' do
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.list_of_journeys).to eq([{station => station}])
  end
end

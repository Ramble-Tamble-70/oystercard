require 'station'

describe Station do
  it 'creates station name upon creation' do
    station = Station.new('Warren St', 1)
  expect(station).to have_attributes(:station_name => 'Warren St')
  end
  
  it 'creates zone number upon creation' do
    station = Station.new('Warren St', 1)
  expect(station).to have_attributes(:zone => 1)
  end
end
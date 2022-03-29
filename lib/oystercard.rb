class Oystercard
  attr_reader :balance, :limit, :MINIMUM_FARE, :entry_station, :exit_station, :list_of_journeys

  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @limit = LIMIT
    @entry_station = nil
    @exit_station = nil
    @list_of_journeys = []
  end

  def top_up(money)
    raise "Cannot top-up. Would exceed #{@limit}" if check_top_up(money)
    @balance += money
  end

  def touch_in(station)
    raise "insufficient funds, less than #{@MINIMUM_FARE}" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    add_journey_history
  end

  def in_journey?
    @entry_station != nil
  end

  def add_journey_history
    @list_of_journeys.push({"#{@entry_station.station_name} #{@entry_station.zone}" => "#{@exit_station.station_name} #{@exit_station.zone}"})
    @entry_station = nil
    @exit_station = nil
  end

  private

  def check_top_up(money)
    @balance + money > @limit
  end
  
  def deduct(money)
    @balance -= money
  end
end

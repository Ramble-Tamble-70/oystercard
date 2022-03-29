class Oystercard
  attr_reader :balance, :limit, :MINIMUM_FARE, :entry_station

  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @limit = LIMIT
    @entry_station = nil
  end

  def top_up(money)
    raise "Cannot top-up. Would exceed #{@limit}" if check_top_up(money)
    @balance += money
  end

  def touch_in(station)
    raise "insufficient funds, less than #{@MINIMUM_FARE}" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def check_top_up(money)
    @balance + money > @limit
  end
  
  def deduct(money)
    @balance -= money
  end
end

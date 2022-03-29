class Oystercard
  attr_reader :balance, :limit, :MINIMUM_FARE, :entry_station
  attr_accessor :card_status

  LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @limit = LIMIT
    @card_status = 'not in use'
    @entry_station = nil
  end

  def top_up(money)
    raise "Cannot top-up. Would exceed #{@limit}" if check_top_up(money)
    @balance += money
  end

  def touch_in(station)
    raise "insufficient funds, less than #{@MINIMUM_FARE}" if @balance < MINIMUM_FARE
    @entry_station = station
    @card_status = 'in use'
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @card_status = 'not in use'
  end

  def in_journey?
    @card_status == 'in use'
  end

  private

  def check_top_up(money)
    @balance + money > @limit
  end
  
  def deduct(money)
    @balance -= money
  end
end

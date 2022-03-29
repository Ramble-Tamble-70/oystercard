class Oystercard
  attr_reader :balance, :limit
  attr_accessor :card_status

  LIMIT = 90

  def initialize
    @balance = 0
    @limit = LIMIT
    @card_status = 'not in use'
  end

  def top_up(money)
    raise "Cannot top-up. Would exceed #{@limit}" if check_top_up(money)

    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def touch_in
    @card_status = 'in use'
  end

  def touch_out
    @card_status = 'not in use'
  end

  def in_journey?
    @card_status == 'in use'
  end

  private

  def check_top_up(money)
    @balance + money > @limit
  end
end

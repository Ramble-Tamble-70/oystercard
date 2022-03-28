
class Oystercard
  attr_reader :balance, :limit

  LIMIT = 90

  def initialize
    @balance = 0
    @limit = LIMIT
  end
  
  def top_up(money)
    raise "Cannot top-up. Would exceed #{@limit}" if check_top_up(money)
    
    @balance += money
  end

  private

  def check_top_up(money)
    @balance + money > @limit
  end
end

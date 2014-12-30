class Equal
  def initialize(cards)
    raise ArgumentError.new('0123456789 と +-*/ 以外の文字があります') unless cards =~ /^[0-9+\-*\/]*$/

    @cards = cards.split('')
  end

  def solved?
  end
end

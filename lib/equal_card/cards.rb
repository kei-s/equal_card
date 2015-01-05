class EqualCard::Cards
  attr_reader :cards, :took_pattern
  def initialize(cards)
    unless cards =~ /^[0-9+\-*\/]*$/
      fail ArgumentError, '0123456789 と +-*/ 以外の文字があります'
    end

    @cards = cards
    @took_pattern = {}
  end

  def answers
    unique = patterns.select { |pattern| valid?(pattern) && unique?(pattern) }
    unique.flat_map { |pattern| EqualCard::Solver.new(pattern).solve }
  end

  private

  def patterns
    @patterns ||= cards.split('').permutation.lazy.map(&:join)
  end

  def valid?(pattern)
    pattern !~ /[+\-*\/]{2,}/ &&
      pattern[0] !~ /[+\-*\/]/ && pattern[-1] !~ /[+\-*\/]/
  end

  def unique?(pattern)
    took = took_pattern[pattern]
    if took
      false
    else
      took_pattern[pattern] = true
      true
    end
  end
end

class Equal::Cards
  attr_reader :cards, :patterns, :taked_pattern
  def initialize(cards)
    raise ArgumentError.new('0123456789 と +-*/ 以外の文字があります') unless cards =~ /^[0-9+\-*\/]*$/

    @cards = cards.split('')
    @patterns = @cards.permutation.lazy
    @taked_pattern = Hash.new
  end

  def answers
    unique = patterns.select { |pattern| unique?(pattern) }
    unique.map { |pattern| Equal::Solver.new(pattern).solve.join('') }
  end

  private

  def unique?(pattern)
    pattern_str = pattern.join('')
    taked = taked_pattern[pattern_str]
    if taked
      false
    else
      taked_pattern[pattern_str] = true
      true
    end
  end
end

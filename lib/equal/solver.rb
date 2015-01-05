class Equal::Solver
  attr_reader :pattern
  def initialize(pattern)
    @pattern = pattern
  end

  def solve
    equal_patterns.select do |ptn|
      exps = ptn.split('=')
      first = eval(exps[0])
      exps.all? do |exp|
        first == eval(exp)
      end
    end
  end

  def equal_patterns
    positions = equalable_positions
    if positions.size == 1
      equal_ptn = pattern.dup
      equal_ptn[positions[0]] = '='
      [equal_ptn]
    else
      (1..positions.size).flat_map do |i|
        positions.combination(i).select do |combi|
          (1..i).all? do |j|
            combi[j - 1] - combi[j - 2] != 1
          end
        end.map do |combi|
          equal_pattern = pattern.dup
          combi.each do |c|
            equal_pattern[c] = '='
          end
          equal_pattern
        end
      end
    end
  end

  def equalable_positions
    pos = -1
    arr = []
    until pos.nil?
      pos = pattern.index(/[0-9].[0-9]/, pos + 1)
      arr << pos + 1 unless pos.nil?
    end
    arr
  end
end

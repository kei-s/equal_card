class Equal::Solver
  attr_reader :pattern
  def initialize(pattern)
    @pattern = pattern
  end

  def solve
    equations.select do |equation|
      exps = equation.split('=')
      first = eval(exps[0])
      exps.all? do |exp|
        first == eval(exp)
      end
    end
  end

  def equations
    equalable_patterns.map do |equalable_position|
      ptn = pattern.dup
      equalable_position.each do |c|
        ptn[c] = '='
      end
      ptn
    end
  end

  def equalable_patterns
    positions = equalable_positions

    (1..positions.size).flat_map do |i|
      positions.combination(i).select do |combi|
        # Prevent 1==1
        (1..i).all? do |j|
          combi[j - 1] - combi[j - 2] != 1
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

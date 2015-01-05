class EqualCard::Solver
  attr_reader :pattern
  def initialize(pattern)
    @pattern = pattern
  end

  def solve
    equations.select do |equation|
      exps = equation.split('=')
      next false unless EqualCard::Solver.valid?(exps)
      first = EqualCard::Solver.eval_exp(exps[0])
      exps.all? do |exp|
        first == EqualCard::Solver.eval_exp(exp)
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

    (1..positions.size).lazy.flat_map do |i|
      positions.combination(i).lazy.select do |combi|
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

  class << self
    def valid?(expressions)
      expressions.all? do |exp|
        exp.split(/[+\-*\/]/).all? do |number|
          !number.start_with?('0')
        end
      end
    end

    def eval_exp(expression)
      calc_add(expression)
    end

    def calc_add(expression)
      expression.scan(/([+-]?)([^+-]+)/).inject(nil) do |result, arr|
        operator, exp = arr
        value = calc_multiply(exp)
        case operator
        when '+' then result + value
        when '-' then result - value
        when ''  then value
        end
      end
    end

    def calc_multiply(expression)
      expression.scan(%r{([*/]?)([^*/]+)}).inject(nil) do |result, arr|
        operator, value = arr
        value = value.to_i
        case operator
        when '*' then result * value
        when '/' then Rational(result, value)
        when ''  then value
        end
      end
    end
  end
end

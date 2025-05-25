module EquationBalancer
  class Parser
    def initialize(equation)
      @equation = equation
    end

    def parse
      left, right = @equation.split('->').map(&:strip)
      raise ArgumentError, "Invalid equation format" if left.nil? || right.nil?

      {
        reactants: parse_compounds(left),
        products: parse_compounds(right)
      }
    end

    private

    def parse_compounds(side)
      side.split('+').map(&:strip).map do |compound|
        validate_formula!(compound)
        parse_formula(compound)
      end
    end

    def parse_formula(formula)
      elements = formula.scan(/([A-Z][a-z]*)(\d*)/)
      elements.each_with_object(Hash.new(0)) do |(element, count), hash|
        hash[element] += (count.empty? ? 1 : count.to_i)
      end
    end

    def validate_formula!(compound)
      unless compound.match?(/\A([A-Z][a-z]*\d*)+\z/)
        raise ArgumentError, "Invalid chemical formula: #{compound}"
      end
    end
  end
end

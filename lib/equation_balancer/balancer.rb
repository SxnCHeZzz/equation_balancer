require_relative 'parser'
require 'matrix'
require 'rational'

module EquationBalancer
  class Balancer
    def initialize(equation)
      @equation = equation
      @parsed = Parser.new(equation).parse
    end

    def balance
      compounds = @parsed[:reactants] + @parsed[:products]
      elements = compounds.flat_map(&:keys).uniq

      matrix_data = elements.map { |el| build_row(el) }
      matrix = Matrix[*matrix_data]

      coeffs = solve_nullspace(matrix)

      format_result(coeffs)
    end

    private

    def build_row(element)
      left = @parsed[:reactants].map { |c| c[element] || 0 }
      right = @parsed[:products].map { |c| -(c[element] || 0) }
      left + right
    end

    def solve_nullspace(matrix)
      rows = matrix.row_count
      cols = matrix.column_count
      mat = matrix.to_a.map { |row| row.map(&:to_r) }

      # Гауссова ликвидация (простой RREF)
      lead = 0
      (0...rows).each do |r|
        if lead >= cols
          break
        end
        i = r
        while mat[i][lead] == 0
          i += 1
          if i == rows
            i = r
            lead += 1
            break if lead == cols
          end
        end

        mat[i], mat[r] = mat[r], mat[i]
        lv = mat[r][lead]
        mat[r] = mat[r].map { |m| m / lv }

        (0...rows).each do |i2|
          next if i2 == r
          lv = mat[i2][lead]
          mat[i2] = mat[i2].zip(mat[r]).map { |a, b| a - lv * b }
        end
        lead += 1
      end

      # Задаём значение 1 последнему свободному коэффициенту
      sol = Array.new(cols, 0)
      sol[-1] = 1

      (rows - 1).downto(0) do |r|
        row = mat[r]
        pivot_col = row.index { |v| v != 0 }
        break unless pivot_col

        sum = 0
        ((pivot_col + 1)...cols).each do |c|
          sum += row[c] * sol[c]
        end
        sol[pivot_col] = -sum
      end

      lcm = sol.map(&:denominator).reduce(1, :lcm)
      sol.map { |x| (x * lcm).to_i }
    end

    def format_result(coeffs)
      parts = @equation.split('->').map { |side| side.strip.split('+').map(&:strip) }
      left = parts[0].each_with_index.map do |compound, i|
        coeffs[i] == 1 ? compound : "#{coeffs[i]}#{compound}"
      end.join(' + ')
      right = parts[1].each_with_index.map do |compound, i|
        idx = i + parts[0].size
        coeffs[idx] == 1 ? compound : "#{coeffs[idx]}#{compound}"
      end.join(' + ')
      "#{left} -> #{right}"
    end
  end
end

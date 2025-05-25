#!/usr/bin/env ruby
require_relative "lib/equation_balancer"

equations = [
  "H2 + O2 -> H2O",
  "C + O2 -> CO2",
  "Fe + O2 -> Fe2O3",
  "Al + HCl -> AlCl3 + H2",
  "Na + H2O -> NaOH + H2"
]

puts "Демонстрация балансировки уравнений:\n\n"

equations.each do |eq|
  begin
    balanced = EquationBalancer.balance(eq)
    puts "Исходное: #{eq}"
    puts "Сбалансированное: #{balanced}"
    puts "-" * 30
  rescue StandardError => e
    puts "Ошибка при балансировке '#{eq}': #{e.message}"
    puts "-" * 30
  end
end
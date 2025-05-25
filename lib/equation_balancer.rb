require_relative 'equation_balancer/balancer'

module EquationBalancer
  def self.balance(equation)
    Balancer.new(equation).balance
  end
end
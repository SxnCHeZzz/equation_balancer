require 'equation_balancer'

RSpec.describe EquationBalancer do
  it 'balances H2 + O2 -> H2O' do
    result = EquationBalancer.balance("H2 + O2 -> H2O")
    expect(result).to eq("2H2 + O2 -> 2H2O")
  end

  it 'balances Fe + O2 -> Fe2O3' do
    result = EquationBalancer.balance("Fe + O2 -> Fe2O3")
    expect(result).to eq("4Fe + 3O2 -> 2Fe2O3")
  end

  it 'balances C2H6 + O2 -> CO2 + H2O' do
    result = EquationBalancer.balance("C2H6 + O2 -> CO2 + H2O")
    expect(result).to eq("2C2H6 + 7O2 -> 4CO2 + 6H2O")
  end
end

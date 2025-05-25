# EquationBalancer

A Ruby gem for balancing chemical equations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'equation_balancer'
And then execute:


$ bundle install
Or install it yourself as:


$ gem install equation_balancer
Usage
Balance a chemical equation by providing a string in the format "reactants -> products":


require 'equation_balancer'

# Example
result = EquationBalancer.balance('H2 + O2 -> H2O')
puts result # Outputs: "2H2 + O2 -> 2H2O"

Development
After checking out the repo, run the following to set up the project:


$ bundle install

To run tests:

$ rspec

Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/SxnCHeZzz/equation_balancer.

License
The gem is available as open source under the terms of the MIT License.
Gem::Specification.new do |s|
  s.name        = 'equation_balancer'
  s.version     = '0.1.0'
  s.summary     = 'A Ruby gem for balancing chemical equations'
  s.description = 'Balances chemical equations provided as strings, e.g., "H2 + O2 -> H2O" becomes "2H2 + O2 -> 2H2O". Includes formula validation.'
  s.authors     = ['SxnCHeZzz']
  s.email       = 'akasharnyy@inbox.ru'
  s.files       = Dir['lib/**/*']
  s.homepage    = 'https://github.com/SxnCHeZzz/equation_balancer'
  s.license     = 'MIT'
  s.add_development_dependency 'rspec', '~> 3.0'
end
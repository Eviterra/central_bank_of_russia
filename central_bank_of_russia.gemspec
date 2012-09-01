Gem::Specification.new do |s|
  s.name         = "central_bank_of_russia"
  s.version      = "0.0.1"
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Alexey 'codesnik' Trofimenko"]
  s.email        = ["aronaxis@gmail.com"]
  s.homepage     = "http://github.com/Eviterra/central_bank_of_russia"
  s.summary      = "Calculates exchange rates based on rates from Central Bank of Russia. Money gem compatible."
  s.description  = "This gem reads exchange rates from the Central Bank of Russia website. It is compatible with the money gem"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "nokogiri"
  s.add_dependency "money",    ">= 5.0.0"

  s.add_development_dependency "rspec", ">= 2.0.0"

  s.files         = Dir.glob("lib/**/*") + %w(CHANGELOG.rdoc LICENSE README.rdoc)
  s.require_path = "lib"
end


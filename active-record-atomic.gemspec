# encoding: utf-8

Gem::Specification.new do |s|
  s.name          = 'active-record-atomic'
  s.version       = '0.2.0'
  s.authors       = ['Black Square Media Ltd']
  s.email         = ['info@blacksquaremedia.com']
  s.summary       = %{Atomic updates to ActiveRecord models}
  s.description   = %{}
  s.homepage      = 'https://github.com/bsm/active-record-atomic'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^spec/}) }
  s.test_files    = `git ls-files -z -- spec/*`.split("\x0")
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'activerecord', '>= 4.2', '< 5.0'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'database_cleaner'

end


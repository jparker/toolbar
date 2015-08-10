$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'toolbar/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'toolbar'
  s.version     = Toolbar::VERSION
  s.authors     = ['John Parker']
  s.email       = ['jparker@urgetopunt.com']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of Toolbar.'
  s.description = 'TODO: Description of Toolbar.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.required_ruby_version = '>= 2.1'

  s.add_dependency 'rails', '~> 4.1'

  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'minitest', '~> 5.7'
  s.add_development_dependency 'minitest-focus'
  s.add_development_dependency 'minitest-reporters'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'sqlite3'
end

# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "domain_name_validator/version"

Gem::Specification.new do |gem|
  gem.name        = "domain_name_validator"
  gem.version     = DomainNameValidator::VERSION
  gem.date        = '2013-06-17'
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ["David Keener"]
  gem.email       = ["dkeener@keenertech.com"]
  gem.homepage    = "http://www.keenertech.com"
  gem.summary     = %q{Domain Name Validator}
  gem.description = %q{Checks the validity of domain names.}
 
  gem.add_development_dependency "rspec"

  gem.rubyforge_project = "domain_name_validator"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  gem.rdoc_options = ["--charset=UTF-8"]
  gem.extra_rdoc_files = %w[README.rdoc LICENSE Changelog.rdoc]

  gem.require_paths = ["lib"]
end

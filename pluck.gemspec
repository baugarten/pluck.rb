# -*- encoding: utf-8 -*-

require File.join(File.dirname(__FILE__), 'lib', 'pluck', 'version')

Gem::Specification.new do |s|
  s.name = 'pluck'
  s.version = Pluck::VERSION
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Augarten"]
  s.summary = "Some command line tools for working with JSON"
  s.email = %q{baugarten@gmail.com}
  s.extra_rdoc_files = ['README.md']
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{http://github.com/baugarten/pluck.rb}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.test_files = `git ls-files`.split("\n").select{|f| f =~ /^spec/}
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.licenses    = ['MIT']

  # dependencies
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'jsonpath'
  s.add_development_dependency 'code_stats'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest', '~> 2.2.0'
  s.add_development_dependency 'phocus'
  s.add_development_dependency 'bundler'
end

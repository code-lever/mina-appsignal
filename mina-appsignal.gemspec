# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina/appsignal/version'

Gem::Specification.new do |spec|
  spec.name          = 'mina-appsignal'
  spec.version       = Mina::AppSignal::VERSION
  spec.authors       = ['Nick Veys']
  spec.email         = ['nick@codelever.com']
  spec.summary       = %q{Mina tasks for AppSignal}
  spec.description   = %q{Notify AppSignal of Mina deployments.}
  spec.homepage      = 'https://github.com/code-lever/mina-appsignal'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'mina', '~> 1.0.0'

  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'ci_reporter', '~> 1.9'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-checkstyle_formatter'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-gem-adapter'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'yard'
end

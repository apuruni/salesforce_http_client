# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'salesforce_http_client/version'

Gem::Specification.new do |spec|
  spec.name          = "salesforce_http_client"
  spec.version       = SalesforceHttpClient::VERSION
  spec.authors       = ["Apuruni"]
  spec.email         = ["apuruni@gmail.com"]
  spec.summary       = "This gem provides a simple way to download report data from salesforce.com using only your sales force login id (=email) and password."
  spec.description   = "This gem provides a simple way to download report data from salesforce.com. It works well with any ruby applications, include such as Ruby on Rails.You can access salesfore.com using only your sales force login id (=email) and password. A security token is no need."
  spec.homepage      = "https://github.com/apuruni/salesforce_http_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'httpclient', '~> 2.6.0.1'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-legacy_formatters"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-rubocop"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "coveralls"
end

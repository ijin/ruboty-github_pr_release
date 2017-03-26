# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/github_pr_release/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-github_pr_release"
  spec.version       = Ruboty::GithubPrRelease::VERSION
  spec.authors       = ["Micahel H. Oshita"]
  spec.email         = ["ijinpublic+github@gmail.com"]

  spec.summary       = %q{Manages a 'release pull request'}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/ijin/ruboty-github_pr_release"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "ruboty-github", "0.2.1"
  spec.add_dependency "diffy", "~> 3.1"
end

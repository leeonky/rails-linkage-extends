
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails/linkage/extends/version"

Gem::Specification.new do |spec|
  spec.name          = "rails-linkage-extends"
  spec.version       = Rails::Linkage::Extends::VERSION
  spec.authors       = ['Liangchen']
  spec.email         = ['leeonky@gmail.com']

  spec.summary       = 'rairs-linkage extends'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 4.2.10'
  spec.add_dependency 'sass-rails'
  spec.add_dependency 'jquery-rails'
  spec.add_runtime_dependency 'rails-linkage'
  spec.add_runtime_dependency 'filter_set'
  spec.add_dependency 'uri-js-rails'
end

require File.expand_path('../lib/motion/objc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Francis Chong"]
  gem.email = ["francis@ignition.hk"]
  gem.description = "Simply include Objective-C files in your RubyMotion projects"
  gem.summary = "Simply include Objective-C files in your RubyMotion projects"
  gem.homepage = "https://github.com/siuying/moiton-objc"

  gem.files = `git ls-files`.split($\)
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.name = "motion-objc"
  gem.require_paths = ["lib"]
  gem.version = MotionObjc::VERSION
  gem.add_dependency 'motion-cocoapods', '>= 1.0.3'
end
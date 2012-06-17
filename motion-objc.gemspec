require File.expand_path('../lib/motion/project/objc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Francis Chong"]
  gem.email = ["francis@ignition.hk"]
  gem.description = "Simply include Objective-C files in your RubyMotion projects"
  gem.summary = "Simply include Objective-C files in your RubyMotion projects"
  gem.homepage = "https://github.com/siuying/motion-objc"

  gem.files = `git ls-files`.split($\)
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.name = "motion-objc"
  gem.require_paths = ["lib"]
  gem.version = Motion::Project::ObjC::VERSION
  gem.add_dependency 'xcodeproj'
end
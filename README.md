# RubyMotion Objective-C (motion-objc)

Include simple Objective-C files in your motion project, without the need of manually
create project file.

## Installation

```
gem install motion-objc
```

## Setup

Add following lines to your project ```Rakefile```

```
require 'rubygems'
require 'motion-objc'
```

Add objective-C files to your project with ```app.objc_files```

```
Motion::Project::App.setup do |app|
  app.name = 'MotionObjCTest'
  app.identifier = 'hk.ignition.objc'
  app.version = '1.0.0'
  app.objc_files = Dir.glob("objc/**/*.*")
end
```

## How it works?

It generate a XCode project with static library target with all your specified 
Objective-C files.

motion-objc is designed for simplify the task to add small snippets written 
in Objective-C to RubyMotion project. If you need to include more complex 
code base, you should create a [CocoaPods Spec](https://github.com/CocoaPods/CocoaPods) 
instead.

## License

Copyright 2012, Francis Chong, Ignition Soft.

This project is released in MIT license.

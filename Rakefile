require "bundler/gem_tasks"
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'rubygems'
require 'bundler/setup'
require 'xcodeproj'
require 'motion-objc'

Motion::Project::App.setup do |app|
  app.name = 'MotionObjCTest'
  app.identifier = 'hk.ignition.objc'
  app.version = '1.0.0'
  app.objc_files = Dir.glob("objc/**/*.*")
end
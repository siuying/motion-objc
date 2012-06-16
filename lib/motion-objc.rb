require "motion/project/objc/version"
require "fileutils"

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

module Motion::Project
  class Config
    # variables :objc_files should work, but it isnt
    attr_accessor :objc_files
    VARS << 'objc_files'
  end

  class << App
    def setup_with_motion_objc
      setup_without_motion_objc do |app|
        yield app

        if app.objc_files && app.objc_files != []
          generator = LibGenerator.new(app.objc_files)
          generator.vendor(app)
        end
      end
    end

    alias setup_without_motion_objc setup
    alias setup setup_with_motion_objc
  end

  class LibGenerator
    attr_accessor :project_path
    attr_accessor :files

    def initialize(files=[])
      @files        = files
    end

    def vendor(app)
      generate(app)
      app.vendor_project @project_path, :xcode, 
        :target     => 'MotionObjC', 
        :products   => ['libMotionObjC.a']
    end

    private

    def headers_path
      @files.select {|f| f =~ /\.h$/}.collect{|f| File.dirname(f) }.uniq
    end

    # OTHER_LDFLAGS for the library
    def ld_flags(app)
      flags = []
      flags << '-ObjC'
      flags += app.frameworks.collect{|f| "-framework #{f}"}
      flags.join(" ")
    end

    # Generate project file
    def generate(app)
      @project_path = Pathname.new(File.expand_path(app.project_dir + '/vendor/MotionObjC'))
      FileUtils.mkdir_p(@project_path)
  
      # basic build config
      @config = {
        'SDKROOT'                     => 'iphoneos',
        'ARCHS'                       => "$(ARCHS_STANDARD_32_BIT)",
        'PUBLIC_HEADERS_FOLDER_PATH'  => "$(TARGET_NAME)",
        'IPHONEOS_DEPLOYMENT_TARGET'  => app.deployment_target || "5.1",
        'HEADER_SEARCH_PATHS'         => headers_path,
        'OTHER_LDFLAGS'               => ld_flags(app)
      }

      @project = Xcodeproj::Project.new
      @target  = @project.targets.new_static_library('MotionObjC')
      @target.buildConfigurations.each do |config|
        config.buildSettings.merge!(@config)
      end
      @files.each do |file|
        full_path = File.expand_path(app.project_dir + '/' + file)
        @target.add_source_file(Pathname.new(full_path).relative_path_from(@project_path))
      end

      @project.save_as(File.join(@project_path, 'MotionObjC.xcodeproj'))
    end
  end
end
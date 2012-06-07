unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

module Motion
  module Project
    class Config
      variable :objc_files
    end

    class << App
      def setup_with_motion_objc
        setup_without_motion_objc

        objc_files = app.config[:objc_files]
        if objc_files && objc_files != []
          generator = LibGenerator.new(objc_files)
          generator.generate
          generator.vendor(app)
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
        @project_path = 'vendor/MotionObjC'
      end

      def generate
        File.mkdir_p(@project_path)

        @project = Xcodeproj::Project.new
        @target  = @project.targets.new_static_library(:ios, 'MotionObjC')
        @files.each do |file|
          @target.add_source_file(Pathname.new(file))
        end
        @project.save_as(File.join(@project_path, 'MotionObjC.xcodeproj'))
      end

      def vendor(app)
        app.vendor_project @project_path, :xcode, :target => 'MotionObjC'
      end
    end
  end
end
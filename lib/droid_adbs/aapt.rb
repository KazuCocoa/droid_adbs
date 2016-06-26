module DroidAdbs
  module Aapt
    class << self
      def get_manifesto(package_path, out_path)
        raise "should set path to aapt, android-sdks/build-tools/xxxx" if `which aapt`.empty?
        dumped_data = `aapt dump xmltree #{package_path} AndroidManifest.xml`
        File.write out_path, dumped_data
      end
    end
  end # module Aapt
end # module DroidAdbs

module DroidAdbs
  module Aapt
    class << self
      # @param [String] package_path
      # @param [String] out_path
      # @raise RuntimeError because get_manifesto can't find aapt command
      # @return [fixnum]
      def get_manifesto(package_path, out_path)
        raise RuntimeError, "should set path to aapt, android-sdks/build-tools/xxxx" if `which aapt`.empty?
        dumped_data = `aapt dump xmltree #{package_path} AndroidManifest.xml`
        File.write out_path, dumped_data
      end
    end
  end # module Aapt
end # module DroidAdbs

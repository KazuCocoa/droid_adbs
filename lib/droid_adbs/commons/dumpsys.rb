module DroidAdbs
  module Dumpsys
    class << self
      # @return [String] about dbinfo via adb command
      def get_dbinfo(package = nil)
        p = package ? package : ""
        `#{::DroidAdbs.shell} dumpsys dbinfo #{p}`.strip
      end
    end
  end
end

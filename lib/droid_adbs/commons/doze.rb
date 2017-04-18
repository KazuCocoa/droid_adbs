module DroidAdbs
  module Doze
    class << self
      # @return [String] message from adb command
      def force_idle
        `#{::DroidAdbs.shell} dumpsys battery unplug`.strip
        `#{::DroidAdbs.shell} dumpsys deviceidle force-idle`.strip

        result = false

        30.times do
          deviceidle = `#{::DroidAdbs.shell} dumpsys deviceidle`.strip
          result = deviceidle.include?("mState=IDLE mLightState=OVERRIDE")
          break if result
          sleep 0.5
        end

        result
      end

      # @return [String] message from adb command
      def reset
        `#{::DroidAdbs.shell} dumpsys deviceidle disable`
        `#{::DroidAdbs.shell} dumpsys deviceidle enable`
        `#{::DroidAdbs.shell} dumpsys battery reset`
      end
    end
  end
end

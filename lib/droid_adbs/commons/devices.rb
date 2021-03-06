module DroidAdbs
  module Devices
    class << self
      ### device infos
      # @return [String] message from adb command
      # @example result of message
      #     docomo/SO-04E_1274-2936/SO-04E:4.2.2/10.3.1.B.0.256/_753rg:user/release-keys
      def device_fingerprint
        `#{::DroidAdbs.shell} getprop ro.build.fingerprint`.strip
      end

      ### device infos
      # @return [String] message from adb command
      # @example result of message
      #     SO-04E
      def device_model
        `#{::DroidAdbs.shell} getprop ro.product.model`.strip
      end

      # @return [String] message from adb command
      # @example result of message
      #     4.2.2
      def device_build_version_release
        `#{::DroidAdbs.shell} getprop ro.build.version.release`.strip
      end

      # @return [String] message from adb command
      # @example result of message
      #     17
      def device_build_version_sdk
        `#{::DroidAdbs.shell} getprop ro.build.version.sdk`.strip
      end

      # @return [String] message from adb command
      # @example result of message
      #     "en"
      def current_language
        language = `#{::DroidAdbs.shell} getprop persist.sys.language`.strip
        return language unless language.empty?

        `#{::DroidAdbs.shell} getprop ro.product.locale.language`.strip
      end

      # @return [String] message from adb command
      # @example result of message
      #     "ja-JP"
      def current_locale
        locale = `#{::DroidAdbs.shell} getprop persist.sys.locale`.strip
        return locale unless locale.empty?

        `#{::DroidAdbs.shell} getprop ro.product.locale`.strip
      end
    end
  end
end

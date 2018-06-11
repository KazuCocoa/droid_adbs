module DroidAdbs
  module Settings
    class << self
      # @return [String] message from adb command
      def disable_always_finish_activities
        `#{::DroidAdbs.shell} settings put global always_finish_activities 0`.strip
      end

      # @return [String] message from adb command
      def enable_always_finish_activities
        `#{::DroidAdbs.shell} settings put global always_finish_activities 1`.strip
      end

      ### Network mode
      # @return [String] message from adb command
      def turn_airplain_mode_on
        result1 = `#{::DroidAdbs.shell} settings put global airplane_mode_on 1`
        result2 = `#{::DroidAdbs.shell} am broadcast -a android.intent.action.AIRPLANE_MODE --ez state true`.strip
        result1.concat result2
      end

      # @return [String] message from adb command
      def turn_airplain_mode_off
        result1 = `#{::DroidAdbs.shell} settings put global airplane_mode_on 0`
        result2 = `#{::DroidAdbs.shell} am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false`.strip
        result1.concat result2
      end

      # @return [String] message from adb command
      def turn_wifi_on
        result1 = `#{::DroidAdbs.shell} settings put global wifi_on 1`
        result2 = `#{::DroidAdbs.shell} am broadcast -a android.intent.action.WIFI_ON --ez state false`.strip
        result1.concat result2
      end

      # @return [String] message from adb command
      def turn_wifi_off
        result1 = `#{::DroidAdbs.shell} settings put global wifi_on 0`
        result2 = `#{::DroidAdbs.shell} am broadcast -a android.intent.action.WIFI_ON --ez state false`.strip
        result1.concat result2
      end

      # @return [String] message from adb command
      def turn_cpu_monitoring_on
        `#{::DroidAdbs.shell} settings put global show_processes 1`.strip
      end

      # @return [String] message from adb command
      def turn_cpu_monitoring_off
        `#{::DroidAdbs.shell} settings put global show_processes 0`.strip
      end

      # @return [String] message from adb command
      def turn_auto_time_on
        `#{::DroidAdbs.shell} settings put global auto_time 1`.strip
      end

      # @return [String] message from adb command
      def turn_auto_time_off
        `#{::DroidAdbs.shell} settings put global auto_time 0`.strip
      end

      # @return [String] message from adb command
      def set_date_to(yyyymmdd, hhmmss)
        turn_auto_time_off
        `#{::DroidAdbs.shell} date -s #{yyyymmdd}.#{hhmmss}`.strip
      end

      # @param [String] format A format to `adb shell date`. `+%Y-%m-%dT%T%z` is one format.
      # @return [String] message from adb command
      def get_date(format = "")
        `#{::DroidAdbs.shell} date #{format}`.strip
      end

      # Only for rooted devices.
      #
      # Default SET format is "MMDDhhmm[[CC]YY][.ss]", that's (2 digits each)
      # month, day, hour (0-23), and minute. Optionally century, year, and second.
      # 060910002016.00
      # Thu Jun  9 10:00:00 GMT 2016
      # @example
      #
      #   # Error case
      #   ::DroidAdbs::Settings.set_date '060910002016.00' #=> "date: cannot set date: Operation not permitted\r\nThu Jun  9 10:00:00 JST 2016"
      #
      def set_date(date)
        turn_auto_time_off
        result = `#{::DroidAdbs.shell} date #{date}`.strip
        `#{::DroidAdbs.shell} am broadcast -a android.intent.action.TIME_SET`

        result
      end

      # animation settings
      # @return [String] message from adb command
      def turn_all_animation_off
        turn_all_animation_off_without_reboot
        intent_boot_completed
        puts "adopt settings..."
        false
      end

      # animation settings
      # @return [String] message from adb command
      def turn_all_animation_off_without_reboot
        unless available_changing_animation?
          puts "the device is not over API Level 17"
          return true
        end

        if all_animation_off?
          puts "already all animation settings are off"
          return true
        end

        scale_off "window_animation_scale"
        scale_off "transition_animation_scale"
        scale_off "animator_duration_scale"
        false
      end

      # @return [String] message from adb command
      def turn_all_animation_on
        turn_all_animation_on_without_reboot
        intent_boot_completed
        puts "adopt settings..."
        false
      end

      # @return [String] message from adb command
      def turn_all_animation_on_without_reboot
        unless available_changing_animation?
          puts "the device is not over API Level 17"
          return true
        end

        if all_animation_on?
          puts "already all animation settings are on"
          return true
        end

        scale_on "window_animation_scale"
        scale_on "transition_animation_scale"
        scale_on "animator_duration_scale"
        false
      end

      private

      def scale_off(setting)
        `#{::DroidAdbs.shell} settings put global #{setting} 0`
      end

      def scale_on(setting)
        `#{::DroidAdbs.shell} settings put global #{setting} 1`
      end

      def get_scale_of(setting)
        result = `#{::DroidAdbs.shell} settings get global #{setting}`.chomp
        return 0 if result == "null"
        result.to_i
      end

      def intent_boot_completed
        `#{::DroidAdbs.shell} am broadcast -a android.intent.action.BOOT_COMPLETED`
      end

      # for window animations
      def window_animation_scale
        get_scale_of "window_animation_scale"
      end

      def transition_animation_scale
        get_scale_of "transition_animation_scale"
      end

      def animator_duration_scale
        get_scale_of "transition_animation_scale"
      end

      def available_changing_animation?
        ::DroidAdbs::Devices.device_build_version_sdk.to_i >= 17
      end

      def all_animation_off?
        return true if window_animation_scale == 0 && transition_animation_scale == 0 && animator_duration_scale == 0
        false
      end

      def all_animation_on?
        return true if window_animation_scale == 1 && transition_animation_scale == 1 && animator_duration_scale == 1
        false
      end

    end
  end
end

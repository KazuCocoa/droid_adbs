require_relative "../../droid_adbs"

module DroidAdbs
  module Settings
    class << self
      # @return [String] message from adb command
      def disable_always_finish_activities
        `#{::DroidAdbs.shell} settings put global always_finish_activities 0`
      end

      # @return [String] message from adb command
      def enable_always_finish_activities
        `#{::DroidAdbs.shell} settings put global always_finish_activities 1`
      end

      ### Network mode
      # @return [String] message from adb command
      def turn_airplain_mode_on
        `#{::DroidAdbs.shell} settings put global airplane_mode_on 1`
        `#{::DroidAdbs.shell} am broadcast -a android.intent.action.AIRPLANE_MODE --ez state true`
      end

      # @return [String] message from adb command
      def turn_airplain_mode_off
        `#{::DroidAdbs.shell} settings put global airplane_mode_on 0`
        `#{::DroidAdbs.shell} am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false`
      end

      # @return [String] message from adb command
      def turn_wifi_on
        `#{::DroidAdbs.shell} settings put global wifi_on 1`
        `#{::DroidAdbs.shell} am broadcast -a android.intent.action.WIFI_ON --ez state false`
      end

      # @return [String] message from adb command
      def turn_wifi_off
        `#{::DroidAdbs.shell} settings put global wifi_on 0`
        `#{::DroidAdbs.shell} am broadcast -a android.intent.action.WIFI_ON --ez state false`
      end

      # @return [String] message from adb command
      def turn_cpu_monitoring_on
        `#{::DroidAdbs.shell} settings put global show_processes 1`
      end

      # @return [String] message from adb command
      def turn_cpu_monitoring_off
        `#{::DroidAdbs.shell} settings put global show_processes 0`
      end

      # @return [String] message from adb command
      def turn_auto_time_on
        `#{::DroidAdbs.shell} settings put global auto_time 1`
      end

      # @return [String] message from adb command
      def turn_auto_time_off
        `#{::DroidAdbs.shell} settings put global auto_time 0`
      end

      # @return [String] message from adb command
      def set_date_to(yyyymmdd, hhmmss)
        turn_auto_time_off
        `#{::DroidAdbs.shell} date -s #{yyyymmdd}.#{hhmmss}`
      end

      # animation settings
      # @return [String] message from adb command
      def turn_all_animation_off
        if ::DroidAdbs::Devices.device_build_version_sdk.to_i < 17
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
        intent_boot_completed
        puts "adopt settings..."
        false
      end

      # @return [String] message from adb command
      def turn_all_animation_on
        if ::DroidAdbs::Devices.device_build_version_sdk.to_i < 17
          puts "the device is not over API Level 17"
          return true
        end

        scale_on "window_animation_scale"
        scale_on "transition_animation_scale"
        scale_on "animator_duration_scale"
        intent_boot_completed
        puts "adopt settings..."
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

      def all_animation_off?
        return true if window_animation_scale == 0 && transition_animation_scale == 0 && animator_duration_scale == 0
        false
      end

    end
  end
end

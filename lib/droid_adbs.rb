require "droid_adbs/version"
require_relative "droid_adbs/commons/settings"
require_relative "droid_adbs/commons/devices"
# require_relative "droid_adbs/commons/debug"
require_relative "droid_adbs/commons/backup"
require_relative "droid_adbs/aapt"

module DroidAdbs
  class << self
    attr_accessor :device_serial

    # @return [String] adb shell command
    def shell
      "#{adb_serial} shell"
    end

    # @return [String] Get results of adb devices command
    def devices
      `#{adb} devices`
    end

    # @return [Array] array of serial number to specify adb command
    def device_serials
      `#{adb} devices`.scan(/^.*\t/).map(&:strip)
    end

    # @param app [String] application path
    # @return [String] message from adb command
    def install(app)
      result = `#{adb_serial} install -r #{app}`
      fail "invalid APK" if result.include?("Invalid APK file:")
      fail "failed to update apk because INSTALL_FAILED_VERSION_DOWNGRADE" if result.include?("INSTALL_FAILED_VERSION_DOWNGRADE")
      result
    end

    # @param package [String] package name you would like to uninstall
    # @return [String] message from adb command
    def uninstall(package)
      `#{adb_serial} uninstall #{package}`
    end

    # @param package [String] package name you would like to uninstall similar ones
    # @return [String] message from adb command
    def uninstall_similar(package)
      installed_packages = installed_similar(package)
      installed_packages.each { |pack| `#{adb_serial} uninstall #{pack}` }
    end

    # @param package [String] package name you would like to delete data in device local
    # @return [String] message from adb command
    def delete_data(package)
      result = `#{shell} pm clear #{package}`.strip
      puts "failed to delete data" unless result == "Success"
    end

    # @param package [String] package name you would like to check installed or not
    # @return [Bool] If the package installed, return true. Else return false
    def installed?(package)
      result = `#{shell} pm list packages -e #{package}`.strip
      return true if result == "package:#{package}"
      false
    end

    # @param package [String] package name you would like to collect similar package
    # @return [Array] all package names
    def installed_similar(package)
      result = `#{shell} pm list packages -e #{package}`.strip
      result.each_line.map { |pack|  pack.strip.sub("package:", "") }
    end

    # @param activity [String] activity name you would like to launch
    # @return [String] message from adb command
    def start(activity)
      `#{shell} am start -n #{activity}`
    end

    # @param account_type [String] accountType of Android OS
    # @return [String] message from adb command
    def launch_login_activity(account_type)
      if ::DroidAdbs::Devices.device_build_version_sdk.to_i >= 21
        `#{shell} am start -a android.settings.ADD_ACCOUNT_SETTINGS --esa authorities #{account_type}`
      else
        puts "Can't launch LoginActivity.java because version of sdk in the target device is lower than 21."
      end
    end

    # @param activity [String] activity name you would like to stop
    # @return [String] message from adb command
    def force_stop(package)
      `#{shell} am force-stop #{package}`
    end

    # @param broadcats_item [String] Target item for broadcast
    # @param broadcast_extra [String] putExtra to send broadcast.
    # @return [String] message from adb command
    def send_broadcast(broadcats_item, broadcast_extra = "")
      `#{shell} am broadcast -a #{broadcats_item} #{broadcast_extra}`
    end

    ## resources
    # @return [String] about cpuinfo via adb command
    def dump_all_cpuinfos
      `#{shell} dumpsys cpuinfo`.scan(/^.*$/).map(&:strip)
    end

    ### Activity
    # @return [String] message from adb command regarding current activities
    def current_activity
      `#{shell} dumpsys window windows | grep -E "mCurrentFocus|mFocusedApp"`
    end

    # @param [String] referrer to broadcast
    # @return [String] message from adb command
    def install_referrer_broadcast(referrer)
      `#{shell} broadcast window -a com.android.vending.INSTALL_REFERRER --include-stopped-packages --es referrer #{referrer}`
    end

    # send referrer for TVs
    # @param [String] referrer to broadcast
    # @return [String] message from adb command
    def broad_install_referrer(ref)
      `#{shell} am broadcast -a com.android.vending.INSTALL_REFERRER --include-stopped-packages --es referrer #{ref}`
    end

    # Emulator should be unlocked after launch emulator with -wipe-data option
    # Should unlock screen if current focus is like `mCurrentFocus=Window{2e85df18 u0 StatusBar}` .
    # @return [String] message from adb command
    def unlock_without_pin
      `#{shell} input keyevent 82`
    end

    def unlock_with_pin(text)
      `#{shell} input text #{text} && #{shell} input keyevent 66`
    end

    def screen_on_or_off
      `#{shell} input keyevent 26`
    end

    private

    def adb
      fail "Please set ANDROID_HOME" unless ENV["ANDROID_HOME"]
      "#{ENV["ANDROID_HOME"]}/platform-tools/adb"
    end

    def adb_serial
      "#{adb} #{device_serial_option}"
    end

    def device_serial_option
      return "" unless device_serial && !device_serial.empty?
      "-s #{device_serial}"
    end
  end
end

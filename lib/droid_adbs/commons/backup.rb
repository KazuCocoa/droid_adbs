module DroidAdbs
  module BackupUtils
    class << self

      # https://developer.android.com/intl/ja/training/backup/autosyncapi.html#testing

      # @raise RuntimeError because backup available over SDK 23
      # @return [String] message from adb command
      def enable_backup_logs
        raise RuntimeError, "Backup support over SDK 23(Android 6.0, M)" unless available_backup?
        `#{::DroidAdbs.shell} setprop log.tag.BackupXmlParserLogging VERBOSE`.strip
      end

      # @param [String] package A package name you would like to backup
      # @raise RuntimeError because backup available over SDK 23
      # @return [String] message from adb command
      def full_backup(package)
        raise RuntimeError, "Backup support over SDK 23(Android 6.0, M)" unless available_backup?
        `#{::DroidAdbs.shell} bmgr run`
        `#{::DroidAdbs.shell} bmgr fullbackup #{package}`.strip
      end

      # @param [String] package A package name you would like to backup
      # @return [String] message from adb command
      def restore(package)
        fail "Backup support over SDK 23(Android 6.0, M)" unless available_backup?
        `#{::DroidAdbs.shell} bmgr restore #{package}`.strip
      end

      # @return [String] message from adb command
      def transports
        `#{::DroidAdbs.shell} bmgr list transports`.strip
      end

      # @param [String] transport
      # @param [String] package A package name you would like to backup
      # @return [String] message from adb command and puts message
      def clear_backup(transport, package)
        result = `#{::DroidAdbs.shell} bmgr wipe #{transport} #{package}`.strip
        puts "You can also clear the backup data and associated metadata wither by turning backup off and on in Settings > Backup."
        result
      end

      # @return [Boolean] Return true if API Level against target device is over 23
      def available_backup?
        ::DroidAdbs::Devices.device_build_version_sdk.to_i >= 23
      end
    end
  end # module Debug
end # module Adb

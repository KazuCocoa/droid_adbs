require_relative "../../droid_adbs"

module DroidAdbs
  module BackupUtils
    class << self

      # https://developer.android.com/intl/ja/training/backup/autosyncapi.html#testing

      def enable_backup_logs
        fail "Backup support over SDK 23(Android 6.0, M)" unless available_backup?
        `#{::DroidAdbs.shell} setprop log.tag.BackupXmlParserLogging VERBOSE`
      end

      def full_backup(package)
        fail "Backup support over SDK 23(Android 6.0, M)" unless available_backup?
        `#{::DroidAdbs.shell} bmgr run`
        `#{::DroidAdbs.shell} bmgr fullbackup #{package}`
      end

      def restore(package)
        fail "Backup support over SDK 23(Android 6.0, M)" unless available_backup?
        `#{::DroidAdbs.shell} bmgr restore #{package}`
      end

      def transports
        `#{::DroidAdbs.shell} bmgr list transports`
      end

      def clear_backup(transport, package)
        `#{::DroidAdbs.shell} bmgr wipe #{transport} #{package}`
        puts "You can also clear the backup data and associated metadata wither by turning backup off and on in Settings > Backup."
      end

      def available_backup?
        ::DroidAdbs::Devices.device_build_version_sdk.to_i >= 23
      end
    end
  end # module Debug
end # module Adb

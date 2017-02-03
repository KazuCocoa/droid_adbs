module DroidAdbs
  module Logcat
    class << self
      # @return [String] Empty string if the command is succeeded
      def clear
        result = `#{::DroidAdbs.shell} logcat -c`
        puts result unless result.empty?
        result
      end

      # @param [Symbol] log_level Log level. Default is warning(:w).
      # @return [String] Message from adb command
      def get(log_level: :w)
        level = validate_log_level log_level
        `#{::DroidAdbs.shell} logcat -d *:#{level}`.strip
      end

      # @param [String] file_path File path to save logcat.
      # @param [Symbol] log_level Log level. Default is warning(:w).
      # @return [String] Message from adb command
      def save_logs_in(file_path:, log_level: :w)
        level = validate_log_level log_level
        `#{::DroidAdbs.shell} logcat -d *:#{level} -f #{file_path}`.strip
      end

      # @return [String] Message from adb command
      def get_sigsegv
        `#{::DroidAdbs.shell} logcat -d *:W | grep "SIGSEGV"`.strip
      end

      private

      def validate_log_level(log_level)
        unless %I(v V d D i I w W e E f F s S).include? log_level
          raise ArgumentError, "log_level requires one of #{%I(v V d D i I w W e E f F s S)}"
        end

        log_level.to_s.upcase
      end
    end
  end
end

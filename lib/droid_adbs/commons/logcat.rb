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

      # @param [String] logcat
      # @return [String|nil] Return a fatal exception
      def filter_fatal_exception(logcat)
        start_mark, end_mark = nil, nil
        ids_and_errors = []
        logcat.each_line.reduce("") do |memo, line|
          if !start_mark
            start_mark = /.+ FATAL EXCEPTION:.+/.match(line)
            if start_mark
              memo.concat(line)
              # ["01-24", "12:24:11.667", "10491", "10491", "E", "AndroidRuntime:", "FATAL", "EXCEPTION:", "main"]
              ids_and_errors = line.split " "
            end
          elsif !end_mark
            # ["01-28", "15:26:25.102", "20019", "29842", "E", "AndroidRuntime:", "at", "com.fingerprints.sensor.FingerprintSensor.waitForFingerAndCaptureImage(Native", "Method)"]
            split_line = line.split " "
            if split_line[0..3] == ids_and_errors[0..3]
              memo.concat line # if end_mark
            else
              end_mark = line
            end
          end
          memo
        end
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

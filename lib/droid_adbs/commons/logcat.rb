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
        do_filter_fatal_exceptions(logcat)[:exceptions].first
      end

      # @param [String] logcat
      # @return [Array[String|nil]] Return a fatal exception
      def filter_fatal_exceptions(logcat)
        do_filter_fatal_exceptions(logcat)[:exceptions]
      end

      private

      def do_filter_fatal_exceptions(logcat)
        start_mark, end_mark, ids_and_errors = nil, nil, []

        logcat.each_line.reduce({exception: "", exceptions: []}) do |memo, line|
          if !start_mark
            start_mark = /.+ FATAL EXCEPTION:.+/.match(line)
            if start_mark
              memo[:exception].concat(line)
              # ["01-24", "12:24:11.667", "10491", "10491", "E", "AndroidRuntime:", "FATAL", "EXCEPTION:", "main"]
              ids_and_errors = split_lines_with_space(line)
            end
          elsif !end_mark
            # ["01-28", "15:26:25.102", "20019", "29842", "E", "AndroidRuntime:", "at", "com.fingerprints.sensor.FingerprintSensor.waitForFingerAndCaptureImage(Native", "Method)"]
            split_line = split_lines_with_space(line)
            if compare_lines split_line, ids_and_errors
              memo[:exception].concat(line) # if end_mark
            else
              end_mark = line
            end
          end

          if end_mark
            memo[:exceptions].push memo[:exception] if !memo[:exception].nil? && !memo[:exception].empty?
            start_mark, end_mark, memo[:exception] = nil, nil, ""
          end

          memo
        end
      end

      def validate_log_level(log_level)
        unless %I(v V d D i I w W e E f F s S).include? log_level
          raise ArgumentError, "log_level requires one of #{%I(v V d D i I w W e E f F s S)}"
        end

        log_level.to_s.upcase
      end

      def split_lines_with_space(line)
        line.split " "
      end

      def compare_lines(line1, line2)
        line1[0..3] == line2[0..3]
      end
    end
  end
end

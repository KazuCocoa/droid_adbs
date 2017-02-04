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
        do_filter_fatal_exceptions(logcat).first
      end

      # @param [String] logcat
      # @return [Array] Return a fatal exception
      def filter_fatal_exceptions(logcat)
        do_filter_fatal_exceptions(logcat)
      end

      private

      def do_filter_fatal_exceptions(logcat)
        has_exception, end_exception, split_line = false, false, []
        tmp_memo = {last_exception: "", exceptions: []}

        logcat.each_line.reduce(tmp_memo) { |memo, line|
          if !has_exception
            has_exception = has_fatal_exception?(line)
            if has_exception
              memo[:last_exception].concat(line)
              split_line = line.split(/\s/)
            end
          elsif !end_exception
            compare_lines(line.split(/\s/), split_line) ? memo[:last_exception].concat(line) : end_exception = true
          end

          # store last exception and clear local variables.
          if end_exception
            memo[:exceptions].push memo[:last_exception] if !memo[:last_exception].nil? && !memo[:last_exception].empty?
            has_exception, end_exception, memo[:last_exception], split_line = false, false, "", []
          end

          memo
        }[:exceptions]
      end

      def validate_log_level(log_level)
        unless %I(v V d D i I w W e E f F s S).include? log_level
          raise ArgumentError, "log_level requires one of #{%I(v V d D i I w W e E f F s S)}"
        end

        log_level.to_s.upcase
      end

      def has_fatal_exception?(line)
        result = /.+ FATAL EXCEPTION:.+/.match(line)
        result.nil? ? false : true
      end

      def compare_lines(line1, line2)
        line1[0..3] == line2[0..3]
      end
    end
  end
end

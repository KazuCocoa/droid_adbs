module DroidAdbs
  module Grant
    class << self
      # @param [String] package A name of package you would like to allow permission
      # @param [Object] permission Permission you would like to allow
      # @return [String] message from adb command
      def grant(package:, permission:)
        result = `#{::DroidAdbs.shell} pm grant #{package} #{permission}`.chomp

        unless result.empty?
          exception = "java.lang.IllegalArgumentException:"
          error_message = result.each_line.find { |line| line.include? exception }.chomp
          raise RuntimeError, message unless error_message.empty?
        end

        result
      end
    end
  end
end

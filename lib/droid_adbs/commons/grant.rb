module DroidAdbs
  module Grant
    class << self
      # @param [String] package A name of package you would like to allow permission
      # @param [Object] permission Permission you would like to allow
      # @return [String] message from adb command
      def grant(package:, permission:)
        result = `#{::DroidAdbs.shell} pm grant #{package} #{permission}`.strip

        unless result.empty?
          exception = "java.lang.IllegalArgumentException:"
          error_message = result.each_line.find { |line| line.include? exception }
          error_message = error_message.chomp unless error_message.nil?
          raise RuntimeError, message unless error_message.empty?
        end

        result
      end

      # @param [String] package A name of package you would like to allow permission
      # @param [Object] permission Permission you would like to revoke
      # @return [String] message from adb command
      def revoke(package:, permission:)
        result = `#{::DroidAdbs.shell} pm revoke #{package} #{permission}`.strip

        unless result.empty?
          exception = "java.lang.IllegalArgumentException:"
          error_message = result.each_line.find { |line| line.include? exception }
          error_message = error_message.chomp unless error_message.nil?
          raise RuntimeError, message unless error_message.empty?
        end

        result
      end
    end
  end
end

module DroidAdbs
  module WM
    class << self
      # @return [Integer] density. If this method fail to get density, then return 0.
      def get_density
        result = `#{::DroidAdbs.shell} wm density`.chomp
        return 0 unless result.match(/\APhysical density:.*/)
        result.split(/\s/).last.to_i
      end

      # @return [String] message from adb commands
      def reset_density
        `#{::DroidAdbs.shell} wm density reset`.chomp
      end

      # Don't forget to call `reset_density` after change density via adb
      # @param [Integer] base_density density with get_density
      # @param [hash] scale :small, :normal, :large, :huge. default is :normal
      # @return [String] message from adb commands
      def set_density(base_density:, scale: :normal)
        density = case scale
                    when :small
                      (base_density * 0.85).to_i
                    when :large
                      (base_density * 1.15).to_i
                    when :huge
                      (base_density * 1.3).to_i
                    else # include :normal
                      base_density
                  end
        `#{::DroidAdbs.shell} wm density #{density}`.chomp
      end

    end
  end
end

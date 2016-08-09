require_relative "../../droid_adbs"

module DroidAdbs
  module IME
    class << self
      # @return [String] message from adb command
      def get_ime_list
        `#{::DroidAdbs.shell} ime list`.chomp
      end

      # @param [String] ime_lists
      # @return [Array] Array of IME ID list such as ["com.agilebits.onepassword/.filling.FillingInputMethodService",
      #   com.google.android.googlequicksearchbox/com.google.android.voicesearch.ime.VoiceInputMethodService"]
      def parse_ime_list(ime_lists)
        ime_lists.each_line.map { |line| line.chomp.scan(/\A\S+:\z/).first }.compact.map(&:chop)
      end
    end
  end
end

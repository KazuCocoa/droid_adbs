require_relative "../../droid_adbs"

module DroidAdbs
  module IME
    class << self
      # @return [String] message from adb command
      def get_ime_list
        `#{::DroidAdbs.shell} ime list`.chomp
      end

      # @param [String] ime_id ID provided by IME such as "com.google.android.inputmethod.japanese/.MozcService"
      # @return [String] message from adb command
      #   if it succeeded to set IME, then it returns "Input method com.google.android.inputmethod.japanese/.MozcService selected"
      #   if it failed to set IME because of no ID, then it returns "Error: Unknown id: ime_id"
      def set_ime(ime_id)
        `#{::DroidAdbs.shell} ime set #{ime_id}`.chomp
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

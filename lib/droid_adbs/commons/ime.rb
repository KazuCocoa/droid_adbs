module DroidAdbs
  module IME
    class << self
      # @return [String] message from adb command as pure string.
      def get_ime_with_string
        `#{::DroidAdbs.shell} ime list`.chomp
      end

      # @return [Array] Array of IME ID list
      # @example
      #   [
      #     "com.agilebits.onepassword/.filling.FillingInputMethodService",
      #     "com.google.android.googlequicksearchbox/com.google.android.voicesearch.ime.VoiceInputMethodService"
      #   ]
      def get_ime_list
        string = get_ime_with_string
        parse_ime_list(string)
      end

      # @param [String] ime_id ID provided by IME such as "com.google.android.inputmethod.japanese/.MozcService"
      # @return [String] message from adb command.
      #     If it succeeded to set IME, then it returns "Input method com.google.android.inputmethod.japanese/.MozcService selected"
      #     If it failed to set IME because of no ID, then it returns "Error: Unknown id: ime_id"
      def set_ime(ime_id)
        `#{::DroidAdbs.shell} ime set #{ime_id}`.chomp
      end

      # @param [String] ime_lists
      # @return [Array] Array of IME ID list
      # @example
      #   [
      #     "com.agilebits.onepassword/.filling.FillingInputMethodService",
      #     "com.google.android.googlequicksearchbox/com.google.android.voicesearch.ime.VoiceInputMethodService"
      #   ]
      def parse_ime_list(ime_lists)
        ime_lists.each_line.map { |line| line.chomp.scan(/\A\S+:\z/).first }.compact.map(&:chop)
      end
    end
  end
end

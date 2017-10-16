module DroidAdbs
  module ScreenRecord
    class Recording
      attr_accessor :bit_rate, :size

      private

      attr_accessor :file_name

      public

      def initialize(device_serial: nil, bit_rate: 3000000, size: "1280x720")
        @bit_rate = bit_rate
        @size = size

        ::DroidAdbs.device_serial = device_serial if device_serial
      end

      def record(file_name:)
        @file_name = file_name

        @process_id = fork do
          exec "#{::DroidAdbs.shell} screenrecord --bit-rate #{@bit_rate} --size #{@size} /sdcard/#{@file_name}.mp4"
        end
      end

      def kill
        Process.kill(:SIGINT, @process_id)

        # Download the video
        system "#{::DroidAdbs.adb_serial} pull /sdcard/#{@file_name}.mp4 #{Dir.pwd}"
        sleep 5 # To finish pull command

        # Delete the video from the device
        system "#{::DroidAdbs.shell} rm /sdcard/#{@file_name}.mp4"
      end
    end
  end
end # module Android
module DroidAdbs
  module ScreenRecord
    class Recording
      attr_accessor :bit_rate, :size

      private

      attr_accessor :file_name, :recording

      public

      def initialize(device_serial: nil, bit_rate: 3000000, size: "1280x720", time_limit: 180)
        @bit_rate = bit_rate
        @size = size
        @time_limit = time_limit

        ::DroidAdbs.device_serial = device_serial if device_serial
        @recording = false
      end

      def start(file_name: "droid_adbs_video")
        validate_recordable?
        raise "Recording on the other process" if @recording

        @file_name = file_name

        @recording = true
        @process_id = fork do
          exec "#{::DroidAdbs.shell} screenrecord --time-limit #{@time_limit} --bit-rate #{@bit_rate} --size #{@size} /sdcard/#{@file_name}.mp4"
        end
      end

      def stop
        validate_recordable?
        Process.kill(:SIGINT, @process_id)
        @recording = false
      end

      def pull(export_to: "#{Dir.pwd}/droid_adbs_video.mp4")
        # Download the video
        system "#{::DroidAdbs.adb_serial} pull /sdcard/#{@file_name}.mp4 #{export_to}"
      end

      def delete
        # Delete the video from the device
        system "#{::DroidAdbs.shell} rm /sdcard/#{@file_name}.mp4"
      end

      private

      def validate_recordable?
        unless ::DroidAdbs::Devices.device_build_version_sdk.to_i >= 19
          raise "The command require over KitKat(API Level 19)"
        end

        true
      end
    end
  end
end # module Android

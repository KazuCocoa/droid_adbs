require 'test_helper'

class DroidAdbsCommonsRecordTest < Minitest::Test
  def test_record
    record = ::DroidAdbs::ScreenRecord::Recording.new
    record.start

    sleep 10

    record.stop

    # Should wait to finish exporting recorded file
    sleep 1

    record.pull
    assert File.exist? "./droid_adbs_video.mp4"

    record.delete
    File.delete "./droid_adbs_video.mp4"
  end
end

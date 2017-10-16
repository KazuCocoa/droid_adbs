require 'test_helper'

class DroidAdbsCommonsRecordTest < Minitest::Test
  def test_record
    record = ::DroidAdbs::ScreenRecord::Recording.new
    record.record file_name: "sample"

    sleep 10

    record.kill
    assert File.exist? "./sample.mp4"

    # tear down
    File.delete "./sample.mp4"
  end
end

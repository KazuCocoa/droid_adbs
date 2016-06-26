require 'test_helper'

class DroidAdbsCommonsSettingsTest < Minitest::Test
  def test_get_manifesto
    skip("need local apk")
    assert(::DroidAdbs::Aapt.get_manifesto("path/to/apk", "test/data/test_manifesto.txt"))
  end
end

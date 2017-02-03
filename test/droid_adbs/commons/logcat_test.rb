require 'test_helper'

class DroidAdbsCommonsLogcatTest < Minitest::Test
  def test_raise_illegal_loglevel
    assert_raises ArgumentError, "log_level requires one of #{%I(v V d D i I w W e E f F s S)}" do
      ::DroidAdbs::Logcat.get(log_level: :no)
    end
  end
end

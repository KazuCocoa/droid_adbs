require 'test_helper'

class DroidAdbsCommonsLogcatTest < Minitest::Test
  def test_clear
    skip("because this method require devices")
    assert_empty(::DroidAdbs::Logcat.clear)
  end

  def test_raise_illegal_loglevel_with_get
    assert_raises ArgumentError, "log_level requires one of #{%I(v V d D i I w W e E f F s S)}" do
      ::DroidAdbs::Logcat.get(log_level: :no)
    end
  end

  def test_raise_illegal_loglevel_with_save_logs_in
    assert_raises ArgumentError, "log_level requires one of #{%I(v V d D i I w W e E f F s S)}" do
      ::DroidAdbs::Logcat.save_logs_in(log_level: :no, file_path: "no file")
    end
  end

  def test_get_sigsegv
    skip("because this method require devices and should get sigsegv...")
    assert_empty(::DroidAdbs::Logcat.get_sigsegv)
  end
end

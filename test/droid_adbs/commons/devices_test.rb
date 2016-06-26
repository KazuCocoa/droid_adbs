require 'test_helper'

class DroidAdbsCommonsDevicesTest < Minitest::Test
  def test_device_fingerprint
    assert(::DroidAdbs::Devices.device_fingerprint)
  end

  def test_device_model
    assert(::DroidAdbs::Devices.device_model)
  end

  def test_device_build_version_release
    assert(::DroidAdbs::Devices.device_build_version_release)
  end

  def test_device_build_version_sdk
    assert(::DroidAdbs::Devices.device_build_version_sdk)
  end

  def test_current_language
    assert(::DroidAdbs::Devices.current_language)
  end

  def test_current_locale
    assert(::DroidAdbs::Devices.current_locale)
  end
end

require 'test_helper'

class DroidAdbsTest < Minitest::Test
  def setup
    @android_adb = "#{ENV['ANDROID_HOME']}/platform-tools/adb"
  end

  def teardown
    ::DroidAdbs.device_serial = ""
  end

  def test_that_it_has_a_version_number
    refute_nil ::DroidAdbs::VERSION
  end

  def test_no_device_serial
    ::DroidAdbs.device_serial = ""
    assert_equal("#{@android_adb}  shell", ::DroidAdbs.shell)
  end

  def test_install_package
    skip("install package depends on package environment")
  end

  def test_uninstall_package
    skip("uninstall package depends on package environment")
  end

  def test_delete_data
    skip("delete data depends on package environment")
  end

  def test_installed?
    assert(::DroidAdbs.installed?("com.android.settings"))
  end

  def test_installed_similar
    assert_equal(["com.android.settings"], ::DroidAdbs.installed_similar("com.android.settings"))
  end

  def test_start_activity
    assert(::DroidAdbs.start("com.android.settings/.SettingsActivity"))
  end

  def test_specific_device_serial
    ::DroidAdbs.device_serial = "serial_number"
    assert_equal("serial_number", ::DroidAdbs.device_serial)
    assert_equal("#{@android_adb} -s serial_number shell", ::DroidAdbs.shell)
  end

  def test_launch_login_activity
    skip("depends on environment")
  end

  def test_force_stop
    assert(::DroidAdbs.force_stop("com.android.settings"))
  end

  def test_broadcast
    assert(::DroidAdbs.send_broadcast("sample"))
  end

  def test_dump_all_cpuinfos
    assert(::DroidAdbs.dump_all_cpuinfos)
  end

  def test_install_referrer_broadcast
    assert(::DroidAdbs.install_referrer_broadcast("referer"))
  end

  def test_broad_install_referrer
    skip("depends on environment")
  end

  # depends on adb connection
  def test_device_serials
    assert(::DroidAdbs.device_serials.length > 0)
  end

  def test_unlock_without_pin
    assert(::DroidAdbs.unlock_without_pin)
  end

  def test_unlock_with_pin
    assert(::DroidAdbs.unlock_with_pin("1234"))
  end

  def test_screen_on_or_off
    assert(::DroidAdbs.screen_on_or_off)
  end

  def test_current_activity
    assert(::DroidAdbs.current_activity.include?("mCurrentFocus"))
  end

  def test_device_fingerprint
    assert(::DroidAdbs::Devices.device_fingerprint.length > 0)
  end

  def test_device_build_version_release
    assert(::DroidAdbs::Devices.device_build_version_release.length > 0)
  end

  def test_device_build_version_sdk
    assert(::DroidAdbs::Devices.device_build_version_sdk.length > 0)
  end

end

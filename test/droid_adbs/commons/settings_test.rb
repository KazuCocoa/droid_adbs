require 'test_helper'

class DroidAdbsCommonsSettingsTest < Minitest::Test
  def test_disable_always_finish_activities
    assert(::DroidAdbs::Settings.disable_always_finish_activities)
  end

  def test_enable_always_finish_activities
    assert(::DroidAdbs::Settings.enable_always_finish_activities)
  end

  def test_turn_airplain_mode_on
    assert(::DroidAdbs::Settings.turn_airplain_mode_on)
  end

  def test_turn_airplain_mode_off
    assert(::DroidAdbs::Settings.turn_airplain_mode_off)
  end

  def test_turn_wifi_on
    assert(::DroidAdbs::Settings.turn_wifi_on)
  end

  def test_turn_wifi_off
    assert(::DroidAdbs::Settings.turn_wifi_off)
  end

  def test_turn_cpu_monitoring_on
    assert(::DroidAdbs::Settings.turn_cpu_monitoring_on)
  end

  def test_turn_cpu_monitoring_off
    assert(::DroidAdbs::Settings.turn_cpu_monitoring_off)
  end

  def test_turn_auto_time_on
    assert(::DroidAdbs::Settings.turn_auto_time_on)
  end

  def test_turn_auto_time_off
    assert(::DroidAdbs::Settings.turn_auto_time_off)
  end

  def test_set_date_to
    assert(::DroidAdbs::Settings.set_date_to(20161111, 000000))
  end

  def test_turn_all_animation_off
    skip("because this method reboot device")
    assert(::DroidAdbs::Settings.turn_all_animation_off)
  end

  def test_turn_all_animation_on
    skip("because this method reboot device")
    assert(::DroidAdbs::Settings.turn_all_animation_on)
  end
end

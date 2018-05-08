require 'test_helper'

class DroidAdbsAnalyzerTest < Minitest::Test
  def setup
    @analyzer = DroidAdbs::Apkanalyzer.new "test/data/api.apk"
  end

  def test_package_id
    assert_equal "io.appium.android.apis", @analyzer.manifest_package_id
  end

  def test_print
    @analyzer.manifest_print
    assert File.size? './manifest_print.xml'

    File.delete './manifest_print.xml' if File.exist? './manifest_print.xml'
  end

  def test_version_name
    # Can be blank
    assert_equal "", @analyzer.manifest_version_name
  end

  def test_version_code
    # Can be "null"
    assert_equal "null", @analyzer.manifest_version_code
  end

  def test_min_sdk
    assert_equal "4", @analyzer.manifest_min_sdk
  end

  def test_target_sdk
    assert_equal "19", @analyzer.manifest_target_sdk
  end

  def test_permissions
    assert_equal [], @analyzer.manifest_permissions
  end

  def test_debuggable
    assert_equal true, @analyzer.manifest_debuggable
  end

  # TODO: Append tests for apk, resources and dex methods
end

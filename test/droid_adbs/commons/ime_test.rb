require 'test_helper'

class DroidAdbsCommonsIMETest < Minitest::Test
  IME_LIST=<<-IME_LIST
com.android.inputmethod.latin/.LatinIME:
  mId=com.android.inputmethod.latin/.LatinIME mSettingsActivityName=com.android.inputmethod.latin.settings.SettingsActivity
  mIsDefaultResId=0x7f090000
  Service:
    priority=0 preferredOrder=0 match=0x108000 specificIndex=-1 isDefault=false
    ServiceInfo:
      name=com.android.inputmethod.latin.LatinIME
      packageName=com.android.inputmethod.latin
      labelRes=0x7f0c002d nonLocalizedLabel=null icon=0x0
      enabled=true exported=true processName=com.android.inputmethod.latin
      permission=android.permission.BIND_INPUT_METHOD
      flags=0x0
com.google.android.googlequicksearchbox/com.google.android.voicesearch.ime.VoiceInputMethodService:
  mId=com.google.android.googlequicksearchbox/com.google.android.voicesearch.ime.VoiceInputMethodService mSettingsActivityName=com.google.android.apps.gsa.velvet.ui.settings.VoiceSearchPreferences
  mIsDefaultResId=0x0
  Service:
    priority=0 preferredOrder=0 match=0x108000 specificIndex=-1 isDefault=false
    ServiceInfo:
      name=com.google.android.voicesearch.ime.VoiceInputMethodService
      packageName=com.google.android.googlequicksearchbox
      labelRes=0x7f0b071c nonLocalizedLabel=null icon=0x0
      enabled=true exported=true processName=com.google.android.googlequicksearchbox:search
      permission=android.permission.BIND_INPUT_METHOD
      flags=0x0
io.appium.android.ime/.UnicodeIME:
  mId=io.appium.android.ime/.UnicodeIME mSettingsActivityName=null
  mIsDefaultResId=0x0
  Service:
    priority=0 preferredOrder=0 match=0x108000 specificIndex=-1 isDefault=false
    ServiceInfo:
      name=io.appium.android.ime.UnicodeIME
      packageName=io.appium.android.ime
      enabled=true exported=true processName=io.appium.android.ime
      permission=android.permission.BIND_INPUT_METHOD
      flags=0x0
com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME:
  mId=com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME mSettingsActivityName=com.google.android.apps.inputmethod.latin.preference.SettingsActivity
  mIsDefaultResId=0x7f080003
  Service:
    priority=0 preferredOrder=0 match=0x108000 specificIndex=-1 isDefault=false
    ServiceInfo:
      name=com.android.inputmethod.latin.LatinIME
      packageName=com.google.android.inputmethod.latin
      labelRes=0x7f0d00ae nonLocalizedLabel=null icon=0x0
      enabled=true exported=true processName=com.google.android.inputmethod.latin
      permission=android.permission.BIND_INPUT_METHOD
      flags=0x0
  IME_LIST

  def test_parse
    ime_list = ::DroidAdbs::IME.parse_ime_list(IME_LIST)
    expected = %W(com.android.inputmethod.latin/.LatinIME
                com.google.android.googlequicksearchbox/com.google.android.voicesearch.ime.VoiceInputMethodService
                io.appium.android.ime/.UnicodeIME
                com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME)
    assert_equal(expected, ime_list)
  end
end

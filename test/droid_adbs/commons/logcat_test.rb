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

  FATAL_EXCEPTION_MORE_EXPECT =<<-EXCEPTION
01-24 12:24:11.667 10491 10491 E AndroidRuntime: FATAL EXCEPTION: main
01-24 12:24:11.667 10491 10491 E AndroidRuntime: Process: com.google.android.music:main, PID: 10491
01-24 12:24:11.667 10491 10491 E AndroidRuntime: java.lang.RuntimeException: Unable to get provider com.google.android.music.store.MusicContentProvider: java.lang.RuntimeException: Could not connect to the preference service
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.installProvider(ActivityThread.java:5385)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.installContentProviders(ActivityThread.java:4955)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.handleBindApplication(ActivityThread.java:4895)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.-wrap1(ActivityThread.java)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread$H.handleMessage(ActivityThread.java:1526)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.os.Handler.dispatchMessage(Handler.java:111)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.os.Looper.loop(Looper.java:207)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.main(ActivityThread.java:5683)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at java.lang.reflect.Method.invoke(Native Method)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.android.internal.os.ZygoteInit$MethodAndArgsCaller.run(ZygoteInit.java:789)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:679)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: Caused by: java.lang.RuntimeException: Could not connect to the preference service
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.preferences.MusicPreferencesServiceDatasource.bindToPreferenceService(MusicPreferencesServiceDatasource.java:78)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.preferences.MusicPreferences.<init>(MusicPreferences.java:383)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.preferences.MusicPreferences$Factory.newInstance(MusicPreferences.java:96)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.Factory$7.create(Factory.java:320)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.Factory$7.create(Factory.java:317)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.LazyProvider.get(LazyProvider.java:26)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.Factory.getMusicPreferences(Factory.java:313)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.store.MusicContentProvider.injectDependencies(MusicContentProvider.java:537)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.store.MusicContentProvider.onCreate(MusicContentProvider.java:544)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.content.ContentProvider.attachInfo(ContentProvider.java:1818)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.content.ContentProvider.attachInfo(ContentProvider.java:1793)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.installProvider(ActivityThread.java:5382)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	... 10 more
  EXCEPTION
  
  FATAL_EXCEPTION_MORE =<<-EXCEPTION
02-04 06:53:50.108  6277  6646 E NetlinkEvent: NetlinkEvent::FindParam(): Parameter 'UID' not found
02-04 06:54:05.759  6550  6687 E ConnectivityService: RemoteException caught trying to send a callback msg for NetworkRequest [ id=472, legacyType=-1, [ Capabilities: INTERNET&NOT_RESTRICTED&TRUSTED] ]
01-24 12:24:11.667 10491 10491 E AndroidRuntime: FATAL EXCEPTION: main
01-24 12:24:11.667 10491 10491 E AndroidRuntime: Process: com.google.android.music:main, PID: 10491
01-24 12:24:11.667 10491 10491 E AndroidRuntime: java.lang.RuntimeException: Unable to get provider com.google.android.music.store.MusicContentProvider: java.lang.RuntimeException: Could not connect to the preference service
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.installProvider(ActivityThread.java:5385)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.installContentProviders(ActivityThread.java:4955)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.handleBindApplication(ActivityThread.java:4895)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.-wrap1(ActivityThread.java)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread$H.handleMessage(ActivityThread.java:1526)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.os.Handler.dispatchMessage(Handler.java:111)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.os.Looper.loop(Looper.java:207)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.main(ActivityThread.java:5683)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at java.lang.reflect.Method.invoke(Native Method)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.android.internal.os.ZygoteInit$MethodAndArgsCaller.run(ZygoteInit.java:789)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:679)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: Caused by: java.lang.RuntimeException: Could not connect to the preference service
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.preferences.MusicPreferencesServiceDatasource.bindToPreferenceService(MusicPreferencesServiceDatasource.java:78)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.preferences.MusicPreferences.<init>(MusicPreferences.java:383)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.preferences.MusicPreferences$Factory.newInstance(MusicPreferences.java:96)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.Factory$7.create(Factory.java:320)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.Factory$7.create(Factory.java:317)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.LazyProvider.get(LazyProvider.java:26)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.Factory.getMusicPreferences(Factory.java:313)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.store.MusicContentProvider.injectDependencies(MusicContentProvider.java:537)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at com.google.android.music.store.MusicContentProvider.onCreate(MusicContentProvider.java:544)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.content.ContentProvider.attachInfo(ContentProvider.java:1818)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.content.ContentProvider.attachInfo(ContentProvider.java:1793)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	at android.app.ActivityThread.installProvider(ActivityThread.java:5382)
01-24 12:24:11.667 10491 10491 E AndroidRuntime: 	... 10 more
02-04 06:53:50.108  6277  6646 E NetlinkEvent: NetlinkEvent::FindParam(): Parameter 'UID' not found
02-04 06:54:05.759  6550  6687 E ConnectivityService: RemoteException caught trying to send a callback msg for NetworkRequest [ id=472, legacyType=-1, [ Capabilities: INTERNET&NOT_RESTRICTED&TRUSTED] ]
  EXCEPTION


  def test_filter_fatal_exception
    assert_equal(FATAL_EXCEPTION_MORE_EXPECT,
                 ::DroidAdbs::Logcat.filter_fatal_exception(FATAL_EXCEPTION_MORE))
  end

  def test_filter_fatal_exception_any_fatals
    assert_equal(FATAL_EXCEPTION_MORE_EXPECT,
                 ::DroidAdbs::Logcat.filter_fatal_exception(FATAL_EXCEPTION_MORE + FATAL_EXCEPTION))
  end

  FATAL_EXCEPTION_EXPECT =<<-EXCEPTION
01-28 15:26:25.102 20019 29842 E AndroidRuntime: FATAL EXCEPTION: Thread-1978
01-28 15:26:25.102 20019 29842 E AndroidRuntime: Process: com.fingerprints.service, PID: 20019
01-28 15:26:25.102 20019 29842 E AndroidRuntime: java.lang.NullPointerException: Attempt to invoke virtual method 'android.os.Message com.fingerprints.service.FingerprintManager$EventHandler.obtainMessage(int, int, int)' on a null object reference
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at android.os.Parcel.readException(Parcel.java:1605)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at android.os.Parcel.readException(Parcel.java:1552)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.service.IFingerprintClient$Stub$Proxy.onMessage(IFingerprintClient.java:120)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.service.ServiceImpl.onCaptureCompleted(ServiceImpl.java:336)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.system.Core.onMessage(Core.java:345)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.sensor.FingerprintSensor.nativeCallback(FingerprintSensor.java:34)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.sensor.FingerprintSensor.waitForFingerAndCaptureImage(Native Method)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.system.Core.identify(Core.java:236)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.system.Core.-wrap2(Core.java)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.system.Core$3.run(Core.java:304)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at java.lang.Thread.run(Thread.java:818)
  EXCEPTION

  FATAL_EXCEPTION =<<-EXCEPTION
02-04 06:53:50.108  6277  6646 E NetlinkEvent: NetlinkEvent::FindParam(): Parameter 'UID' not found
02-04 06:54:05.759  6550  6687 E ConnectivityService: RemoteException caught trying to send a callback msg for NetworkRequest [ id=472, legacyType=-1, [ Capabilities: INTERNET&NOT_RESTRICTED&TRUSTED] ]
01-28 15:26:25.102 20019 29842 E AndroidRuntime: FATAL EXCEPTION: Thread-1978
01-28 15:26:25.102 20019 29842 E AndroidRuntime: Process: com.fingerprints.service, PID: 20019
01-28 15:26:25.102 20019 29842 E AndroidRuntime: java.lang.NullPointerException: Attempt to invoke virtual method 'android.os.Message com.fingerprints.service.FingerprintManager$EventHandler.obtainMessage(int, int, int)' on a null object reference
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at android.os.Parcel.readException(Parcel.java:1605)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at android.os.Parcel.readException(Parcel.java:1552)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.service.IFingerprintClient$Stub$Proxy.onMessage(IFingerprintClient.java:120)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.service.ServiceImpl.onCaptureCompleted(ServiceImpl.java:336)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.system.Core.onMessage(Core.java:345)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.sensor.FingerprintSensor.nativeCallback(FingerprintSensor.java:34)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.sensor.FingerprintSensor.waitForFingerAndCaptureImage(Native Method)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.system.Core.identify(Core.java:236)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.system.Core.-wrap2(Core.java)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at com.fingerprints.system.Core$3.run(Core.java:304)
01-28 15:26:25.102 20019 29842 E AndroidRuntime: 	at java.lang.Thread.run(Thread.java:818)
02-04 06:53:50.108  6277  6646 E NetlinkEvent: NetlinkEvent::FindParam(): Parameter 'UID' not found
02-04 06:54:05.759  6550  6687 E ConnectivityService: RemoteException caught trying to send a callback msg for NetworkRequest [ id=472, legacyType=-1, [ Capabilities: INTERNET&NOT_RESTRICTED&TRUSTED] ]
  EXCEPTION

  def test_filter_fatal_exception_no_more
    assert_equal(FATAL_EXCEPTION_EXPECT,
                 ::DroidAdbs::Logcat.filter_fatal_exception(FATAL_EXCEPTION))
  end

  def test_filter_fatal_exception_no_more_any_fatals
    assert_equal(FATAL_EXCEPTION_EXPECT,
                 ::DroidAdbs::Logcat.filter_fatal_exception(FATAL_EXCEPTION + FATAL_EXCEPTION_MORE))
  end

  def test_filter_fatal_exceptions
    assert_equal([FATAL_EXCEPTION_MORE_EXPECT, FATAL_EXCEPTION_EXPECT],
                 ::DroidAdbs::Logcat.filter_fatal_exceptions(FATAL_EXCEPTION_MORE + FATAL_EXCEPTION))
  end


  def test_filter_no_fatal_exception
    assert_nil(::DroidAdbs::Logcat.filter_fatal_exception(""))
  end

  def test_filter_no_fatal_exceptions
    assert_equal([], ::DroidAdbs::Logcat.filter_fatal_exceptions(""))
  end
end

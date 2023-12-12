import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

enum AppStoreDeviceType {
  androidPortrait,
}

extension AppStoreDeviceTypeExtensions on AppStoreDeviceType {
  Size get size => switch (this) {
        AppStoreDeviceType.androidPortrait => const Size(1080, 1920),
      };

  DeviceInfo get frame => switch (this) {
        AppStoreDeviceType.androidPortrait => Devices.android.onePlus8Pro,
      };

  TargetPlatform get platform => switch (this) {
        AppStoreDeviceType.androidPortrait => TargetPlatform.android,
      };
}

typedef ScreenshotScenario = ({
  ScreenBuilder onBuildScreen,
  ScreenWrapper? wrapper,
  PostPumpCallback? onPostPumped,
  Color backgroundColor,
  Map<Locale, String> text,
  TextStyle? textStyle,
  ThemeData? theme,
});

typedef ScreenshotsConfig = ({
  Iterable<AppStoreDeviceType> devices,
  Iterable<Locale> locales,
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
});

typedef AppIconBuilder = Widget Function();

typedef ScreenBuilder = Widget Function();

typedef ScreenWrapper = Widget Function(Widget);

typedef PostPumpCallback = Future<void> Function(WidgetTester);

typedef GooglePlayFeatureGraphicBuilder = Widget Function(Locale);

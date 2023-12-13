import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

enum AppStoreDeviceType {
  androidPortrait,
  androidLandscape,
  linux,
  macOS,
  windows,
}

extension AppStoreDeviceTypeExtensions on AppStoreDeviceType {
  Size get size => switch (this) {
        AppStoreDeviceType.androidPortrait => const Size(1080, 1920),
        AppStoreDeviceType.androidLandscape => const Size(1920, 1080),
        AppStoreDeviceType.linux => const Size(1920, 1080),
        AppStoreDeviceType.macOS => const Size(1920, 1080),
        AppStoreDeviceType.windows => const Size(1920, 1080),
      };

  DeviceInfo get frame => switch (this) {
        AppStoreDeviceType.androidPortrait => Devices.android.onePlus8Pro,
        AppStoreDeviceType.androidLandscape => Devices.android.onePlus8Pro,
        AppStoreDeviceType.linux => Devices.linux.laptop,
        AppStoreDeviceType.macOS => Devices.macOS.macBookPro,
        AppStoreDeviceType.windows => Devices.windows.laptop,
      };

  TargetPlatform get platform => switch (this) {
        AppStoreDeviceType.androidPortrait => TargetPlatform.android,
        AppStoreDeviceType.androidLandscape => TargetPlatform.android,
        AppStoreDeviceType.linux => TargetPlatform.linux,
        AppStoreDeviceType.macOS => TargetPlatform.macOS,
        AppStoreDeviceType.windows => TargetPlatform.windows,
      };

  Orientation get orientation => switch (this) {
        AppStoreDeviceType.androidPortrait => Orientation.portrait,
        AppStoreDeviceType.androidLandscape => Orientation.landscape,
        AppStoreDeviceType.linux => Orientation.landscape,
        AppStoreDeviceType.macOS => Orientation.landscape,
        AppStoreDeviceType.windows => Orientation.landscape,
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

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

enum AppStoreDeviceType {
  androidPhonePortrait,
  androidPhoneLandscape,
  iOSPhone47Portrait,
  iOSPhone47Landscape,
  linux,
  macOS,
  windows,
}

extension AppStoreDeviceTypeExtensions on AppStoreDeviceType {
  Size get size => switch (this) {
        AppStoreDeviceType.androidPhonePortrait => const Size(1080, 1920),
        AppStoreDeviceType.androidPhoneLandscape => const Size(1920, 1080),
        AppStoreDeviceType.iOSPhone47Portrait => const Size(750, 1334),
        AppStoreDeviceType.iOSPhone47Landscape => const Size(1334, 750),
        AppStoreDeviceType.linux => const Size(1920, 1080),
        AppStoreDeviceType.macOS => const Size(1920, 1080),
        AppStoreDeviceType.windows => const Size(1920, 1080),
      };

  DeviceInfo get frame => switch (this) {
        AppStoreDeviceType.androidPhonePortrait => Devices.android.onePlus8Pro,
        AppStoreDeviceType.androidPhoneLandscape => Devices.android.onePlus8Pro,
        AppStoreDeviceType.iOSPhone47Portrait => Devices.ios.iPhoneSE,
        AppStoreDeviceType.iOSPhone47Landscape => Devices.ios.iPhoneSE,
        AppStoreDeviceType.linux => Devices.linux.laptop,
        AppStoreDeviceType.macOS => Devices.macOS.macBookPro,
        AppStoreDeviceType.windows => Devices.windows.laptop,
      };

  TargetPlatform get platform => switch (this) {
        AppStoreDeviceType.androidPhonePortrait => TargetPlatform.android,
        AppStoreDeviceType.androidPhoneLandscape => TargetPlatform.android,
        AppStoreDeviceType.iOSPhone47Portrait => TargetPlatform.iOS,
        AppStoreDeviceType.iOSPhone47Landscape => TargetPlatform.iOS,
        AppStoreDeviceType.linux => TargetPlatform.linux,
        AppStoreDeviceType.macOS => TargetPlatform.macOS,
        AppStoreDeviceType.windows => TargetPlatform.windows,
      };

  Orientation get orientation => switch (this) {
        AppStoreDeviceType.androidPhonePortrait => Orientation.portrait,
        AppStoreDeviceType.androidPhoneLandscape => Orientation.landscape,
        AppStoreDeviceType.iOSPhone47Portrait => Orientation.portrait,
        AppStoreDeviceType.iOSPhone47Landscape => Orientation.landscape,
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

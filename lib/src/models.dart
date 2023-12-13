import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

enum DeviceType {
  androidPhonePortrait,
  androidPhoneLandscape,
  androidTablet7Portrait,
  androidTablet7Landscape,
  androidTablet10Portrait,
  androidTablet10Landscape,
  iOSPhone47Portrait,
  iOSPhone47Landscape,
  iOSPhone55Portrait,
  iOSPhone55Landscape,
  linux,
  macOS,
  windows,
}

extension DeviceTypeExtensions on DeviceType {
  Size get size => switch (this) {
        DeviceType.androidPhonePortrait => const Size(1080, 1920),
        DeviceType.androidPhoneLandscape => const Size(1920, 1080),
        DeviceType.androidTablet7Portrait => const Size(1080, 1920),
        DeviceType.androidTablet7Landscape => const Size(1920, 1080),
        DeviceType.androidTablet10Portrait => const Size(1080, 1920),
        DeviceType.androidTablet10Landscape => const Size(1920, 1080),
        DeviceType.iOSPhone47Portrait => const Size(750, 1334),
        DeviceType.iOSPhone47Landscape => const Size(1334, 750),
        DeviceType.iOSPhone55Portrait => const Size(1242, 2208),
        DeviceType.iOSPhone55Landscape => const Size(2208, 1242),
        DeviceType.linux => const Size(1920, 1080),
        DeviceType.macOS => const Size(1920, 1080),
        DeviceType.windows => const Size(1920, 1080),
      };

  DeviceInfo get frame => switch (this) {
        DeviceType.androidPhonePortrait => Devices.android.onePlus8Pro,
        DeviceType.androidPhoneLandscape => Devices.android.onePlus8Pro,
        DeviceType.androidTablet7Portrait => Devices.android.mediumTablet,
        DeviceType.androidTablet7Landscape => Devices.android.mediumTablet,
        DeviceType.androidTablet10Portrait => Devices.android.largeTablet,
        DeviceType.androidTablet10Landscape => Devices.android.largeTablet,
        DeviceType.iOSPhone47Portrait => Devices.ios.iPhoneSE,
        DeviceType.iOSPhone47Landscape => Devices.ios.iPhoneSE,
        DeviceType.iOSPhone55Portrait =>
          Devices.ios.iPhone13Mini, // should be iPhone 8 Plus, iPhone 7 Plus or iPhone 6s Plus
        DeviceType.iOSPhone55Landscape =>
          Devices.ios.iPhone13Mini, // should be iPhone 8 Plus, iPhone 7 Plus or iPhone 6s Plus
        DeviceType.linux => Devices.linux.laptop,
        DeviceType.macOS => Devices.macOS.macBookPro,
        DeviceType.windows => Devices.windows.laptop,
      };

  TargetPlatform get platform => switch (this) {
        DeviceType.androidPhonePortrait => TargetPlatform.android,
        DeviceType.androidPhoneLandscape => TargetPlatform.android,
        DeviceType.androidTablet7Portrait => TargetPlatform.android,
        DeviceType.androidTablet7Landscape => TargetPlatform.android,
        DeviceType.androidTablet10Portrait => TargetPlatform.android,
        DeviceType.androidTablet10Landscape => TargetPlatform.android,
        DeviceType.iOSPhone47Portrait => TargetPlatform.iOS,
        DeviceType.iOSPhone47Landscape => TargetPlatform.iOS,
        DeviceType.iOSPhone55Portrait => TargetPlatform.iOS,
        DeviceType.iOSPhone55Landscape => TargetPlatform.iOS,
        DeviceType.linux => TargetPlatform.linux,
        DeviceType.macOS => TargetPlatform.macOS,
        DeviceType.windows => TargetPlatform.windows,
      };

  Orientation get orientation => switch (this) {
        DeviceType.androidPhonePortrait => Orientation.portrait,
        DeviceType.androidPhoneLandscape => Orientation.landscape,
        DeviceType.androidTablet7Portrait => Orientation.portrait,
        DeviceType.androidTablet7Landscape => Orientation.landscape,
        DeviceType.androidTablet10Portrait => Orientation.portrait,
        DeviceType.androidTablet10Landscape => Orientation.landscape,
        DeviceType.iOSPhone47Portrait => Orientation.portrait,
        DeviceType.iOSPhone47Landscape => Orientation.landscape,
        DeviceType.iOSPhone55Portrait => Orientation.portrait,
        DeviceType.iOSPhone55Landscape => Orientation.landscape,
        DeviceType.linux => Orientation.landscape,
        DeviceType.macOS => Orientation.landscape,
        DeviceType.windows => Orientation.landscape,
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
  Iterable<DeviceType> devices,
  Iterable<Locale> locales,
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
});

typedef AppIconBuilder = Widget Function();

typedef ScreenBuilder = Widget Function();

typedef ScreenWrapper = Widget Function(Widget);

typedef PostPumpCallback = Future<void> Function(WidgetTester);

typedef GooglePlayFeatureGraphicBuilder = Widget Function(Locale);

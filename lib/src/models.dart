import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

enum DeviceType {
  androidPhonePortrait,
  androidPhoneLandscape,
  iOSPhone47Portrait,
  iOSPhone47Landscape,
  linux,
  macOS,
  windows,
}

extension DeviceTypeExtensions on DeviceType {
  Size get size => switch (this) {
        DeviceType.androidPhonePortrait => const Size(1080, 1920),
        DeviceType.androidPhoneLandscape => const Size(1920, 1080),
        DeviceType.iOSPhone47Portrait => const Size(750, 1334),
        DeviceType.iOSPhone47Landscape => const Size(1334, 750),
        DeviceType.linux => const Size(1920, 1080),
        DeviceType.macOS => const Size(1920, 1080),
        DeviceType.windows => const Size(1920, 1080),
      };

  DeviceInfo get frame => switch (this) {
        DeviceType.androidPhonePortrait => Devices.android.onePlus8Pro,
        DeviceType.androidPhoneLandscape => Devices.android.onePlus8Pro,
        DeviceType.iOSPhone47Portrait => Devices.ios.iPhoneSE,
        DeviceType.iOSPhone47Landscape => Devices.ios.iPhoneSE,
        DeviceType.linux => Devices.linux.laptop,
        DeviceType.macOS => Devices.macOS.macBookPro,
        DeviceType.windows => Devices.windows.laptop,
      };

  TargetPlatform get platform => switch (this) {
        DeviceType.androidPhonePortrait => TargetPlatform.android,
        DeviceType.androidPhoneLandscape => TargetPlatform.android,
        DeviceType.iOSPhone47Portrait => TargetPlatform.iOS,
        DeviceType.iOSPhone47Landscape => TargetPlatform.iOS,
        DeviceType.linux => TargetPlatform.linux,
        DeviceType.macOS => TargetPlatform.macOS,
        DeviceType.windows => TargetPlatform.windows,
      };

  Orientation get orientation => switch (this) {
        DeviceType.androidPhonePortrait => Orientation.portrait,
        DeviceType.androidPhoneLandscape => Orientation.landscape,
        DeviceType.iOSPhone47Portrait => Orientation.portrait,
        DeviceType.iOSPhone47Landscape => Orientation.landscape,
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

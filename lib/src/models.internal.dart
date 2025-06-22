import 'package:device_frame/device_frame.dart' hide DeviceType;
import 'package:flutter/widgets.dart';

import 'models.dart';

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
        DeviceType.iOSPhone65Portrait => const Size(1242, 2688),
        DeviceType.iOSPhone65Landscape => const Size(2688, 1242),
        DeviceType.iOSPhone69Portrait => const Size(1320, 2868),
        DeviceType.iOSPhone69Landscape => const Size(2868, 1320),
        DeviceType.iOSTablet129Portrait => const Size(2048, 2732),
        DeviceType.iOSTablet129Landscape => const Size(2732, 2048),
        DeviceType.iOSTablet13Portrait => const Size(2064, 2752),
        DeviceType.iOSTablet13Landscape => const Size(2752, 2064),
        DeviceType.linux => const Size(1920, 1080),
        DeviceType.macOS => const Size(1920, 1080),
        DeviceType.windows => const Size(1920, 1080),
      };

  DeviceInfo get frame => switch (this) {
        DeviceType.androidPhonePortrait => Devices.android.googlePixel9,
        DeviceType.androidPhoneLandscape => Devices.android.googlePixel9,
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
        DeviceType.iOSPhone65Portrait => Devices.ios.iPhone13ProMax,
        DeviceType.iOSPhone65Landscape => Devices.ios.iPhone13ProMax,
        DeviceType.iOSPhone69Portrait => Devices.ios.iPhone16ProMax,
        DeviceType.iOSPhone69Landscape => Devices.ios.iPhone16ProMax,
        DeviceType.iOSTablet129Portrait => Devices.ios.iPad12InchesGen4,
        DeviceType.iOSTablet129Landscape => Devices.ios.iPad12InchesGen4,
        DeviceType.iOSTablet13Portrait => Devices.ios.iPadPro13InchesM4,
        DeviceType.iOSTablet13Landscape => Devices.ios.iPadPro13InchesM4,
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
        DeviceType.iOSPhone65Portrait => TargetPlatform.iOS,
        DeviceType.iOSPhone65Landscape => TargetPlatform.iOS,
        DeviceType.iOSPhone69Portrait => TargetPlatform.iOS,
        DeviceType.iOSPhone69Landscape => TargetPlatform.iOS,
        DeviceType.iOSTablet129Portrait => TargetPlatform.iOS,
        DeviceType.iOSTablet129Landscape => TargetPlatform.iOS,
        DeviceType.iOSTablet13Portrait => TargetPlatform.iOS,
        DeviceType.iOSTablet13Landscape => TargetPlatform.iOS,
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
        DeviceType.iOSPhone65Portrait => Orientation.portrait,
        DeviceType.iOSPhone65Landscape => Orientation.landscape,
        DeviceType.iOSPhone69Portrait => Orientation.portrait,
        DeviceType.iOSPhone69Landscape => Orientation.landscape,
        DeviceType.iOSTablet129Portrait => Orientation.portrait,
        DeviceType.iOSTablet129Landscape => Orientation.landscape,
        DeviceType.iOSTablet13Portrait => Orientation.portrait,
        DeviceType.iOSTablet13Landscape => Orientation.landscape,
        DeviceType.linux => Orientation.landscape,
        DeviceType.macOS => Orientation.landscape,
        DeviceType.windows => Orientation.landscape,
      };
}

extension ScreenshotTextPositionExtensions on ScreenshotTextPosition {
  bool get isTop => this == ScreenshotTextPosition.top;

  bool get isBottom => this == ScreenshotTextPosition.bottom;
}

extension ScreenshotForegroundOptionsExtension on ScreenshotForegroundOptions? {
  /// Merges [this] with [other]
  ///
  /// If both are null, default values are returned
  ScreenshotForegroundOptions merge(ScreenshotForegroundOptions? other) {
    if (this == null && other == null) {
      return const ScreenshotForegroundOptions.top();
    } else if (this == null) {
      return other!;
    } else if (other == null) {
      return this!;
    }

    return other.copyWith(
      padding: this!.padding,
      position: this!.position,
      deviceHeightPercentage: this!.deviceHeightPercentage,
      textStyle: this!.textStyle,
      spacer: this!.spacer,
      textAlign: this!.textAlign,
    );
  }
}

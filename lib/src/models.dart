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
  iOSPhone65Portrait,
  iOSPhone65Landscape,
  iOSPhone67Portrait,
  iOSPhone67Landscape,
  iOSTablet129Portrait,
  iOSTablet129Landscape,
  linux,
  macOS,
  windows,
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

class ScreenshotsConfig {
  final Iterable<DeviceType> devices;
  final Iterable<Locale> locales;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  ScreenshotsConfig({
    required this.devices,
    required this.locales,
    this.localizationsDelegates,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotsConfig &&
        other.devices == devices &&
        other.locales == locales &&
        other.localizationsDelegates == localizationsDelegates;
  }

  @override
  int get hashCode => devices.hashCode ^ locales.hashCode ^ localizationsDelegates.hashCode;
}

typedef AppIconBuilder = Widget Function();

typedef ScreenBuilder = Widget Function();

typedef ScreenWrapper = Widget Function(Widget);

typedef PostPumpCallback = Future<void> Function(WidgetTester);

typedef GooglePlayFeatureGraphicBuilder = Widget Function(Locale);

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

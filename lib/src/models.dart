import 'package:flutter/foundation.dart';
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

class ScreenshotScenario {
  final ScreenBuilder onBuildScreen;
  final ScreenWrapper? wrapper;
  final PostPumpCallback? onPostPumped;
  final Color backgroundColor;
  final Map<Locale, String> text;
  final TextStyle? textStyle;
  final ThemeData? theme;

  ScreenshotScenario({
    required this.onBuildScreen,
    this.wrapper,
    this.onPostPumped,
    required this.backgroundColor,
    required this.text,
    this.textStyle,
    this.theme,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotScenario &&
        other.onBuildScreen == onBuildScreen &&
        other.wrapper == wrapper &&
        other.onPostPumped == onPostPumped &&
        other.backgroundColor == backgroundColor &&
        mapEquals(other.text, text) &&
        other.textStyle == textStyle &&
        other.theme == theme;
  }

  @override
  int get hashCode {
    return onBuildScreen.hashCode ^
        wrapper.hashCode ^
        onPostPumped.hashCode ^
        backgroundColor.hashCode ^
        text.hashCode ^
        textStyle.hashCode ^
        theme.hashCode;
  }
}

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

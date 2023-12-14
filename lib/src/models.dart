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

class ScreenshotsConfig {
  final Iterable<DeviceType> devices;
  final Iterable<Locale> locales;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final ScreenshotBackground background;
  final TextStyle? textStyle;
  final ThemeData? theme;

  ScreenshotsConfig({
    required this.devices,
    required this.locales,
    this.localizationsDelegates,
    required this.background,
    this.textStyle,
    this.theme,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotsConfig &&
        other.devices == devices &&
        other.locales == locales &&
        other.localizationsDelegates == localizationsDelegates &&
        other.background == background &&
        other.textStyle == textStyle &&
        other.theme == theme;
  }

  @override
  int get hashCode {
    return devices.hashCode ^
        locales.hashCode ^
        localizationsDelegates.hashCode ^
        background.hashCode ^
        textStyle.hashCode ^
        theme.hashCode;
  }
}

class ScreenshotScenario {
  final ScreenBuilder onBuildScreen;
  final ScreenWrapper? wrapper;
  final PostPumpCallback? onPostPumped;
  final bool isFrameVisible;
  final ScreenshotBackground? background;
  final Map<Locale, String> text;
  final TextStyle? textStyle;
  final ThemeData? theme;

  ScreenshotScenario({
    required this.onBuildScreen,
    this.wrapper,
    this.onPostPumped,
    this.isFrameVisible = true,
    this.background,
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
        other.isFrameVisible == isFrameVisible &&
        other.background == background &&
        mapEquals(other.text, text) &&
        other.textStyle == textStyle &&
        other.theme == theme;
  }

  @override
  int get hashCode {
    return onBuildScreen.hashCode ^
        wrapper.hashCode ^
        onPostPumped.hashCode ^
        isFrameVisible.hashCode ^
        background.hashCode ^
        text.hashCode ^
        textStyle.hashCode ^
        theme.hashCode;
  }
}

class ScreenshotBackground {
  ScreenshotBackground.solid({
    required Color color,
  }) : widget = ColoredBox(
          color: color,
        );

  ScreenshotBackground.gradient({
    required Gradient gradient,
  }) : widget = DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        );

  ScreenshotBackground.widget({
    required this.widget,
  });

  final Widget widget;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotBackground && other.widget == widget;
  }

  @override
  int get hashCode => widget.hashCode;
}

typedef AppIconBuilder = Widget Function();

typedef ScreenBuilder = Widget Function();

typedef ScreenWrapper = Widget Function(Widget);

typedef PostPumpCallback = Future<void> Function(WidgetTester);

typedef GooglePlayFeatureGraphicBuilder = Widget Function(Locale);

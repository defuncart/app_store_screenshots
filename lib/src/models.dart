import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// All supported device types
enum DeviceType {
  /// Android phone 1920x1080 Orientation: Portrait
  androidPhonePortrait,

  /// Android phone 1920x1080 Orientation: Landscape
  androidPhoneLandscape,

  /// Android 7" Tablet Orientation: Portrait
  androidTablet7Portrait,

  /// Android 7" Tablet Orientation: Landscape
  androidTablet7Landscape,

  /// Android 10" Tablet Orientation: Portrait
  androidTablet10Portrait,

  /// Android 10" Tablet Orientation: Landscape
  androidTablet10Landscape,

  /// iPhone 4.7" Orientation: Portrait
  iOSPhone47Portrait,

  /// iPhone 4.7" Orientation: Landscape
  iOSPhone47Landscape,

  /// iPhone 5.5" Orientation: Portrait
  iOSPhone55Portrait,

  /// iPhone 5.5" Orientation: Landscape
  iOSPhone55Landscape,

  /// iPhone 6.5" Orientation: Portrait
  iOSPhone65Portrait,

  /// iPhone 6.5" Orientation: Landscape
  iOSPhone65Landscape,

  /// iPhone 6.7" Orientation: Portrait
  iOSPhone67Portrait,

  /// iPhone 6.7" Orientation: Landscape
  iOSPhone67Landscape,

  /// iPad 12.9" Orientation: Portrait
  iOSTablet129Portrait,

  /// iPad 12.9" Orientation: Landscape
  iOSTablet129Landscape,

  /// Laptop running Linux
  linux,

  /// Laptop running macOS
  macOS,

  /// Laptop running Windows
  windows,
}

/// A base configuration used for all screenshots
class ScreenshotsConfig {
  /// Supported device types
  ///
  /// Typically a subset, i.e. [DeviceType.androidPhonePortrait, DeviceType.iOSPhone67Portrait, DeviceType.iOSPhone55Portrait]
  ///
  /// See [DeviceType] for more info
  final Iterable<DeviceType> devices;

  /// Supported locales, a screenshot will be generated for each locale
  final Iterable<Locale> locales;

  /// Optional localization delegates. Required when screens use intl.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// Background used for all screenshots (unless overridden)
  final ScreenshotBackground background;

  /// Text options for all screenshots (unless overridden)
  final ScreenshotTextOptions? textOptions;

  /// Theme used for all screenshots (unless overridden)
  final ThemeData? theme;

  /// A base configuration used for all screenshots
  ScreenshotsConfig({
    required this.devices,
    required this.locales,
    this.localizationsDelegates,
    required this.background,
    this.textOptions,
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
        other.textOptions == textOptions &&
        other.theme == theme;
  }

  @override
  int get hashCode {
    return devices.hashCode ^
        locales.hashCode ^
        localizationsDelegates.hashCode ^
        background.hashCode ^
        textOptions.hashCode ^
        theme.hashCode;
  }
}

/// A scenario for a specific screenshot
class ScreenshotScenario {
  /// Optional callback before screen is generated
  FutureOr<void> Function(Locale)? onSetUp;

  /// Callback to build the screen
  final ScreenBuilder onBuildScreen;

  /// Optional wrapper, useful for dependency injection (i.e. riverpod, bloc, provider)
  final ScreenWrapper? wrapper;

  /// Optional callback after widget has been pumped
  ///
  /// Useful when a UI element needs interaction before taking screenshot (i.e. enter text in search field)
  final PostPumpCallback? onPostPumped;

  /// Whether device frame should be visible
  final bool isFrameVisible;

  /// Optional background, when null default from [ScreenshotsConfig] is used
  final ScreenshotBackground? background;

  /// Text for the screenshot
  final ScreenshotText? text;

  /// Optional theme, when null default from [ScreenshotsConfig] is used
  final ThemeData? theme;

  /// Optional callback after screen is generated
  FutureOr<void> Function()? onTearDown;

  /// A scenario for a specific screenshot
  ScreenshotScenario({
    this.onSetUp,
    required this.onBuildScreen,
    this.wrapper,
    this.onPostPumped,
    this.isFrameVisible = true,
    this.background,
    this.text,
    this.theme,
    this.onTearDown,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotScenario &&
        other.onSetUp == onSetUp &&
        other.onBuildScreen == onBuildScreen &&
        other.wrapper == wrapper &&
        other.onPostPumped == onPostPumped &&
        other.isFrameVisible == isFrameVisible &&
        other.background == background &&
        other.text == text &&
        other.theme == theme &&
        other.onTearDown == onTearDown;
  }

  @override
  int get hashCode {
    return onSetUp.hashCode ^
        onBuildScreen.hashCode ^
        wrapper.hashCode ^
        onPostPumped.hashCode ^
        isFrameVisible.hashCode ^
        background.hashCode ^
        text.hashCode ^
        theme.hashCode ^
        onTearDown.hashCode;
  }
}

/// A background for a specific screenshot
class ScreenshotBackground {
  /// A background with a solid color
  ScreenshotBackground.solid({
    required Color color,
  }) : widget = ColoredBox(
          color: color,
        );

  /// A background with a gradient
  ScreenshotBackground.gradient({
    required Gradient gradient,
  }) : widget = DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        );

  /// A background with a custom widget (i.e CustomPainter)
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

/// Text position in a screenshot
enum ScreenshotTextPosition {
  top,
  bottom,
}

/// Text options for a screenshot
class ScreenshotTextOptions {
  /// Text position
  final ScreenshotTextPosition position;

  /// Optional text style
  final TextStyle? textStyle;

  /// Spacer between screen and text, defaults to 16
  final double spacer;

  /// Optional text alignment
  final TextAlign? textAlign;

  const ScreenshotTextOptions({
    this.position = ScreenshotTextPosition.top,
    this.textStyle,
    this.spacer = 16,
    this.textAlign,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotTextOptions &&
        other.position == position &&
        other.textStyle == textStyle &&
        other.spacer == spacer &&
        other.textAlign == textAlign;
  }

  @override
  int get hashCode {
    return position.hashCode ^ textStyle.hashCode ^ spacer.hashCode ^ textAlign.hashCode;
  }
}

typedef LocalizedTextGenerator = String Function(Locale);

/// Text for a specific screenshot
class ScreenshotText {
  /// A function to generate the localized label text
  final LocalizedTextGenerator onGenerateText;

  /// Text options, when null default from [ScreenshotConfig] is used
  final ScreenshotTextOptions? options;

  const ScreenshotText({
    required this.onGenerateText,
    this.options,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotText && other.onGenerateText == onGenerateText && other.options == options;
  }

  @override
  int get hashCode => onGenerateText.hashCode ^ options.hashCode;
}

class ScreenshotUnsupportedLocale extends ArgumentError {
  ScreenshotUnsupportedLocale(Locale locale) : super.value(locale, '', 'Unsupported Locale');
}

typedef ScreenBuilder = Widget Function();

typedef ScreenWrapper = Widget Function(Widget);

typedef PostPumpCallback = Future<void> Function(WidgetTester);

typedef AppIconBuilder = Widget Function(double);

typedef GooglePlayFeatureGraphicBuilder = Widget Function(Locale);

typedef AssetBuilder = Widget Function(Size);

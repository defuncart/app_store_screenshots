import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'models.internal.dart';

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

  /// Foreground options for all screenshots (unless overridden)
  final ScreenshotForegroundOptions? foregroundOptions;

  /// Theme used for all screenshots (unless overridden)
  final ThemeData? theme;

  /// A base configuration used for all screenshots
  ScreenshotsConfig({
    required this.devices,
    required this.locales,
    this.localizationsDelegates,
    required this.background,
    this.foregroundOptions,
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
        other.foregroundOptions == foregroundOptions &&
        other.theme == theme;
  }

  @override
  int get hashCode {
    return devices.hashCode ^
        locales.hashCode ^
        localizationsDelegates.hashCode ^
        background.hashCode ^
        foregroundOptions.hashCode ^
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

  /// Optional foreground options, when null default from [ScreenshotsConfig] is used
  final ScreenshotForegroundOptions? foregroundOptions;

  /// A function to generate the localized label text
  ///
  /// Either text as String or Widget is expected
  final LocalizedTextGenerator? onGenerateText;

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
    this.foregroundOptions,
    this.onGenerateText,
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
        other.foregroundOptions == foregroundOptions &&
        other.onGenerateText == onGenerateText &&
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
        foregroundOptions.hashCode ^
        onGenerateText.hashCode ^
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

const _foregroundDefaultPadding = EdgeInsets.all(48);
const double _foregroundDefaultSpacer = 16;

/// Foreground options for a screenshot
class ScreenshotForegroundOptions {
  final EdgeInsets padding;

  /// Text position
  final ScreenshotTextPosition position;

  /// The percentage of device to display on screen
  ///
  /// Only applicable for [ScreenshotTextPosition.top], defaults to 1
  final double? deviceHeightPercentage;

  /// Optional text style
  final TextStyle? textStyle;

  /// Spacer between screen and text, defaults to 16
  final double spacer;

  /// Optional text alignment
  final TextAlign? textAlign;

  const ScreenshotForegroundOptions._({
    this.padding = _foregroundDefaultPadding,
    required this.position,
    this.deviceHeightPercentage,
    this.textStyle,
    this.spacer = _foregroundDefaultSpacer,
    this.textAlign,
  });

  /// Displays optional text above device whose height can be adjusted (i.e. bottom off screen)
  const ScreenshotForegroundOptions.top({
    // TODO: consider adding a check for bottom padding when deviceHeightPercentage < 1
    this.padding = _foregroundDefaultPadding,
    double? deviceHeightPercentage,
    this.textStyle,
    this.spacer = _foregroundDefaultSpacer,
    this.textAlign,
  })  : position = ScreenshotTextPosition.top,
        deviceHeightPercentage = deviceHeightPercentage ?? 1;

  /// Displays optional text below device
  const ScreenshotForegroundOptions.bottom({
    this.padding = _foregroundDefaultPadding,
    this.textStyle,
    this.spacer = _foregroundDefaultSpacer,
    this.textAlign,
  })  : position = ScreenshotTextPosition.bottom,
        deviceHeightPercentage = null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotForegroundOptions &&
        other.padding == padding &&
        other.position == position &&
        other.deviceHeightPercentage == deviceHeightPercentage &&
        other.textStyle == textStyle &&
        other.spacer == spacer &&
        other.textAlign == textAlign;
  }

  @override
  int get hashCode {
    return padding.hashCode ^
        position.hashCode ^
        deviceHeightPercentage.hashCode ^
        textStyle.hashCode ^
        spacer.hashCode ^
        textAlign.hashCode;
  }

  ScreenshotForegroundOptions copyWith({
    EdgeInsets? padding,
    ScreenshotTextPosition? position,
    double? deviceHeightPercentage,
    TextStyle? textStyle,
    double? spacer,
    TextAlign? textAlign,
  }) =>
      ScreenshotForegroundOptions._(
        padding: padding ?? this.padding,
        position: position ?? this.position,
        deviceHeightPercentage:
            (position ?? this.position).isBottom ? null : deviceHeightPercentage ?? this.deviceHeightPercentage,
        textStyle: textStyle ?? this.textStyle,
        spacer: spacer ?? this.spacer,
        textAlign: textAlign ?? this.textAlign,
      );
}

typedef LocalizedTextGenerator = dynamic Function(Locale);

class ScreenshotUnsupportedLocale extends ArgumentError {
  ScreenshotUnsupportedLocale(Locale locale) : super.value(locale, '', 'Unsupported Locale');
}

typedef ScreenBuilder = Widget Function();

typedef ScreenWrapper = Widget Function(Widget);

typedef PostPumpCallback = Future<void> Function(WidgetTester);

typedef AppIconBuilder = Widget Function(double);

typedef GooglePlayFeatureGraphicBuilder = Widget Function(Locale);

typedef AssetBuilder = Widget Function(Size);

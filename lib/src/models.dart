import 'package:flutter/foundation.dart';
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
  linuxLaptop,

  /// Monitor running Linux
  linuxMonitor,

  /// Laptop running Linux
  macOSLaptop,

  /// Monitor running Linux
  macOSMonitor,

  /// Laptop running Linux
  windowsLaptop,

  /// Monitor running Linux
  windowsMonitor,
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

  /// Layout used for all screenshots (unless overridden by scenario)
  final ScreenshotLayout layout;

  /// A base configuration used for all screenshots
  ScreenshotsConfig({
    required this.devices,
    required this.locales,
    this.localizationsDelegates,
    required this.layout,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotsConfig &&
        other.devices == devices &&
        other.locales == locales &&
        other.localizationsDelegates == localizationsDelegates &&
        other.layout == layout;
  }

  @override
  int get hashCode {
    return devices.hashCode ^ locales.hashCode ^ localizationsDelegates.hashCode ^ layout.hashCode;
  }
}

/// Layout for all screenshots (unless overridden by scenario)
class ScreenshotLayout {
  /// Background
  final ScreenshotBackground background;

  /// Optional label TextStyle
  final TextStyle? textStyle;

  /// Optional theme
  final ThemeData? theme;

  /// Margin padding
  final EdgeInsets margin;

  /// Spacer between text and screen device
  final double spacer;

  /// Layout for all screenshots (unless overridden by scenario)
  ScreenshotLayout({
    required this.background,
    this.textStyle,
    this.theme,
    this.margin = const EdgeInsets.all(48),
    this.spacer = 16,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotLayout &&
        other.background == background &&
        other.textStyle == textStyle &&
        other.theme == theme &&
        other.margin == margin &&
        other.spacer == spacer;
  }

  @override
  int get hashCode {
    return background.hashCode ^ textStyle.hashCode ^ theme.hashCode ^ margin.hashCode ^ spacer.hashCode;
  }
}

/// A scenario for a specific screenshot
class ScreenshotScenario {
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

  /// Text options for the screenshot
  final ScreenshotText? text;

  /// Optional label TextStyle, when null default from [ScreenshotsConfig] is used
  final TextStyle? textStyle;

  /// Optional theme, when null default from [ScreenshotsConfig] is used
  final ThemeData? theme;

  /// Optional margin padding, when null default from [ScreenshotsConfig] is used
  final EdgeInsets? margin;

  /// Optional spacer between text and screen device, when null default from [ScreenshotsConfig] is used
  final double? spacer;

  /// Optional size to restrict how large screen is
  final Size? screenAndFrameSize;

  /// A scenario for a specific screenshot
  ScreenshotScenario({
    required this.onBuildScreen,
    this.wrapper,
    this.onPostPumped,
    this.isFrameVisible = true,
    this.background,
    this.text,
    this.textStyle,
    this.theme,
    this.margin,
    this.spacer,
    this.screenAndFrameSize,
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
        other.text == text &&
        other.textStyle == textStyle &&
        other.theme == theme &&
        other.margin == margin &&
        other.spacer == spacer &&
        other.screenAndFrameSize == screenAndFrameSize;
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
        theme.hashCode ^
        margin.hashCode ^
        spacer.hashCode ^
        screenAndFrameSize.hashCode;
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

/// Text options for a specific screenshot
class ScreenshotText {
  const ScreenshotText({
    required this.text,
    this.position = ScreenshotTextPosition.top,
  });

  /// Localized label texts
  ///
  /// Note: Locales need to match as specified in [ScreenshotsConfig]
  final Map<Locale, String> text;

  /// Text position
  final ScreenshotTextPosition position;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScreenshotText && mapEquals(other.text, text) && other.position == position;
  }

  @override
  int get hashCode => text.hashCode ^ position.hashCode;
}

typedef ScreenBuilder = Widget Function();

typedef ScreenWrapper = Widget Function(Widget);

typedef PostPumpCallback = Future<void> Function(WidgetTester);

typedef AppIconBuilder = Widget Function();

typedef GooglePlayFeatureGraphicBuilder = Widget Function(Locale);

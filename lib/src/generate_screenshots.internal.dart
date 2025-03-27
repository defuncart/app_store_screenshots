import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'models.dart';
import 'models.internal.dart';

Widget createScreenContents({
  required ScreenBuilder onBuildScreen,
  ScreenWrapper? wrapper,
  required Locale locale,
  required TargetPlatform platform,
  ThemeData? theme,
  TextStyle? textStyle,
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  Iterable<Locale>? supportedLocales,
}) {
  final widget = MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: localizationsDelegates,
    supportedLocales: supportedLocales ?? const [Locale('en')],
    locale: locale,
    theme: theme?.copyWith(platform: platform),
    home: Material(child: onBuildScreen()),
  );

  return wrapper != null ? wrapper(widget) : widget;
}

Widget createScreenshot({
  required ScreenshotBackground background,
  String? text,
  ScreenshotForegroundOptions? foregroundOptions,
  required Widget screenContents,
  required DeviceInfo deviceFrame,
  required bool isFrameVisible,
  required Orientation orientation,
  required double height,
}) {
  final effectiveForegroundOptions = foregroundOptions ?? const ScreenshotForegroundOptions.top();

  return SizedBox(
    height: height,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        // Background
        SizedBox.expand(
          child: background.widget,
        ),
        // Content
        SizedBox(
          height: height,
          child: Padding(
            padding: effectiveForegroundOptions.padding,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (text != null && effectiveForegroundOptions.position.isTop) ...[
                  Text(
                    text,
                    textAlign: effectiveForegroundOptions.textAlign,
                    style: effectiveForegroundOptions.textStyle,
                  ),
                  SizedBox(height: effectiveForegroundOptions.spacer),
                ],
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        height: constraints.maxHeight,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                              // when 0 < deviceHeightPercentage < 1, position frame accordingly
                              bottom: effectiveForegroundOptions.deviceHeightPercentage != null &&
                                      effectiveForegroundOptions.deviceHeightPercentage! > 0 &&
                                      effectiveForegroundOptions.deviceHeightPercentage! < 1
                                  ? -constraints.maxHeight *
                                      (1 - (effectiveForegroundOptions.deviceHeightPercentage ?? 0))
                                  : null,
                              child: DeviceFrame(
                                device: deviceFrame,
                                isFrameVisible: isFrameVisible,
                                orientation: orientation,
                                screen: screenContents,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (text != null && effectiveForegroundOptions.position.isBottom) ...[
                  SizedBox(height: effectiveForegroundOptions.spacer),
                  Text(
                    text,
                    textAlign: effectiveForegroundOptions.textAlign,
                    style: effectiveForegroundOptions.textStyle,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Future<void> takeScreenshot({
  required WidgetTester tester,
  required Widget widget,
  PostPumpCallback? onPostPumped,
  required String name,
  required Size size,
}) async {
  await tester.pumpWidgetBuilder(
    widget,
    surfaceSize: size,
  );
  if (onPostPumped != null) {
    await onPostPumped(tester);
  }
  await screenMatchesGolden(tester, name);
}

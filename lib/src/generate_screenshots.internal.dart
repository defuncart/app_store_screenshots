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

typedef InternalScreenshotText = ({
  String text,
  ScreenshotTextPosition position,
});

extension ScreenshotTextExtensions on ScreenshotText? {
  InternalScreenshotText? toInternalModel(Locale locale) {
    if (this == null || !this!.text.containsKey(locale)) {
      return null;
    }

    return (
      text: this!.text[locale]!,
      position: this!.position,
    );
  }
}

Widget createScreenshot({
  required ScreenshotBackground background,
  InternalScreenshotText? text,
  required Widget screenContents,
  required DeviceInfo deviceFrame,
  required bool isFrameVisible,
  required Orientation orientation,
  required double height,
  TextStyle? textStyle,
}) =>
    SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background
          SizedBox.expand(
            child: background.widget,
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(48),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (text != null && text.position.isTop) ...[
                  Text(
                    text.text,
                    style: textStyle,
                  ),
                  const SizedBox(height: 16),
                ],
                Expanded(
                  child: DeviceFrame(
                    device: deviceFrame,
                    isFrameVisible: isFrameVisible,
                    orientation: orientation,
                    screen: screenContents,
                  ),
                ),
                if (text != null && text.position.isBottom) ...[
                  const SizedBox(height: 16),
                  Text(
                    text.text,
                    style: textStyle,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

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

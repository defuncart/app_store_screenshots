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
  dynamic text,
  required ScreenshotForegroundOptions foregroundOptions,
  required Widget screenContents,
  required DeviceInfo deviceFrame,
  required bool isFrameVisible,
  required Orientation orientation,
  required double height,
}) {
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
            padding: foregroundOptions.padding,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (foregroundOptions.position.isTop) ...[
                  _LabelText(
                    text,
                    textAlign: foregroundOptions.textAlign,
                    style: foregroundOptions.textStyle,
                  ),
                  SizedBox(height: foregroundOptions.spacer),
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
                              bottom: foregroundOptions.deviceHeightPercentage != null &&
                                      foregroundOptions.deviceHeightPercentage! > 0 &&
                                      foregroundOptions.deviceHeightPercentage! < 1
                                  ? -constraints.maxHeight * (1 - (foregroundOptions.deviceHeightPercentage ?? 0))
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
                if (foregroundOptions.position.isBottom) ...[
                  SizedBox(height: foregroundOptions.spacer),
                  _LabelText(
                    text,
                    textAlign: foregroundOptions.textAlign,
                    style: foregroundOptions.textStyle,
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

class _LabelText extends StatelessWidget {
  const _LabelText(
    this.text, {
    this.textAlign,
    this.style,
  });

  final dynamic text;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    if (text != null) {
      if (text is String) {
        return Text(
          text,
          textAlign: textAlign,
          style: style,
        );
      } else if (text is Widget) {
        return text;
      }
    }

    return const SizedBox.shrink();
  }
}

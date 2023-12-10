import 'dart:io';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import 'models.dart';

@isTest
void generateAppStoreScreenshots({
  VoidCallback? onSetUp,
  required ScreenshotsConfig config,
  required List<ScreenshotScenario> screens,
  VoidCallback? onTearDown,
  bool? skip,
}) {
  testGoldens(
    'Generate screenshots',
    (tester) async {
      await loadAppFonts();

      onSetUp?.call();

      for (final screen in screens) {
        final screenshotNumber = screens.indexOf(screen) + 1;
        for (final device in config.devices) {
          for (final locale in config.locales) {
            await takeScreenshot(
              tester: tester,
              widget: createScreenshot(
                backgroundColor: screen.backgroundColor,
                text: screen.text[locale],
                screenContents: createScreenContents(
                  onBuildScreen: screen.onBuildScreen,
                  wrapper: screen.wrapper,
                  locale: locale,
                  platform: device.platform,
                  theme: screen.theme,
                  localizationsDelegates: config.localizationsDelegates,
                  supportedLocales: config.locales,
                ),
                height: device.size.height,
                phoneFrameDevice: device.frame,
                textStyle: screen.textStyle,
              ),
              onPostPumped: screen.onPostPumped,
              name: p.join('screenshots', device.name, locale.languageCode, 'screenshot_$screenshotNumber'),
              size: device.size,
            );
          }
        }
      }

      moveGoldens('screenshots');

      onTearDown?.call();
    },
    skip: skip,
  );
}

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
  required Color backgroundColor,
  String? text,
  required Widget screenContents,
  required DeviceInfo phoneFrameDevice,
  required double height,
  TextStyle? textStyle,
}) =>
    Container(
      height: height,
      color: backgroundColor,
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (text != null)
            Text(
              text,
              style: textStyle,
            ),
          SizedBox(
            height: text != null ? height * 0.83 : null,
            child: DeviceFrame(
              device: phoneFrameDevice,
              isFrameVisible: true,
              orientation: Orientation.portrait,
              screen: screenContents,
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

void moveGoldens(String dirName) {
  // determine path to app_store_screenshots
  final basedir = (goldenFileComparator as LocalFileComparator).basedir;
  var testFolderPath = basedir.path.replaceAll(Directory.current.path, '');
  if (testFolderPath.startsWith('/')) {
    testFolderPath = testFolderPath.substring(1);
  }

  final goldenPath = p.join(testFolderPath, 'goldens', dirName);
  final outputPath = p.join('assets_dev', dirName);

  // create output folder if necessary
  if (!Directory(outputPath).existsSync()) {
    Directory(outputPath).createSync(recursive: true);
  }

  // delete target folder if needed
  if (Directory(outputPath).existsSync()) {
    Directory(outputPath).deleteSync(recursive: true);
  }

  Directory(goldenPath).renameSync(outputPath);
}

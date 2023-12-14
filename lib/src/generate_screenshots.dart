import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import 'common.dart';
import 'generate_screenshots.internal.dart';
import 'models.dart';
import 'models.internal.dart';

/// Generates [screen] number of screenshots with a given [config]
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
                background: screen.background ?? config.background,
                text: screen.text[locale],
                screenContents: createScreenContents(
                  onBuildScreen: screen.onBuildScreen,
                  wrapper: screen.wrapper,
                  locale: locale,
                  platform: device.platform,
                  theme: screen.theme ?? config.theme,
                  localizationsDelegates: config.localizationsDelegates,
                  supportedLocales: config.locales,
                ),
                height: device.size.height,
                deviceFrame: device.frame,
                isFrameVisible: screen.isFrameVisible,
                orientation: device.orientation,
                textStyle: screen.textStyle ?? config.textStyle,
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

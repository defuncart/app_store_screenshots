import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import 'common.dart';
import 'generate_screenshots.internal.dart';
import 'models.dart';
import 'models.internal.dart';

/// Generates [screen] number of screenshots with a given [config]
///
/// [onSetUp] is called before each screen is generated
///
/// [onTearDown] is called after each screen has been generated
@isTest
void generateAppStoreScreenshots({
  VoidCallback? onSetUp,
  required ScreenshotsConfig config,
  required List<ScreenshotScenario> screens,
  VoidCallback? onTearDown,
  bool? skip,
}) {
  for (final screen in screens) {
    final screenshotNumber = screens.indexOf(screen) + 1;
    for (final device in config.devices) {
      for (final locale in config.locales) {
        testGoldensWithShadows(
          () => testGoldens(
            'Generate screenshot $screenshotNumber ${device.name} $locale',
            (tester) async {
              await loadAppFonts();
              onSetUp?.call();

              await takeScreenshot(
                tester: tester,
                widget: createScreenshot(
                  background: screen.background ?? config.layout.background,
                  margin: screen.margin ?? config.layout.margin,
                  text: screen.text.toInternalModel(locale),
                  spacer: screen.spacer ?? config.layout.spacer,
                  screenContents: createScreenContents(
                    onBuildScreen: screen.onBuildScreen,
                    wrapper: screen.wrapper,
                    locale: locale,
                    platform: device.platform,
                    theme: screen.theme ?? config.layout.theme,
                    localizationsDelegates: config.localizationsDelegates,
                    supportedLocales: config.locales,
                  ),
                  height: device.size.height,
                  deviceFrame: device.frame,
                  screenAndFrameSize: screen.screenAndFrameSize,
                  isFrameVisible: screen.isFrameVisible,
                  orientation: device.orientation,
                  textStyle: screen.textStyle ?? config.layout.textStyle,
                ),
                onPostPumped: screen.onPostPumped,
                name: p.join('screenshots', device.name, locale.languageCode, 'screenshot_$screenshotNumber'),
                size: device.size,
              );

              onTearDown?.call();

              // once all goldens are generated, move to target folder
              if (screen == screens.last && device == config.devices.last && locale == config.locales.last) {
                moveGoldens('screenshots');
              }
            },
            skip: skip,
          ),
        );
      }
    }
  }
}

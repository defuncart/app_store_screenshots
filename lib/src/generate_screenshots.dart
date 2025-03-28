import 'dart:async';

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
  FutureOr<void> Function()? onSetUp,
  required ScreenshotsConfig config,
  required List<ScreenshotScenario> screens,
  FutureOr<void> Function()? onTearDown,
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
              await onSetUp?.call();
              await screen.onSetUp?.call(locale);

              await takeScreenshot(
                tester: tester,
                widget: createScreenshot(
                  background: screen.background ?? config.background,
                  text: screen.onGenerateText?.call(locale),
                  foregroundOptions: screen.foregroundOptions.merge(config.foregroundOptions),
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
                ),
                onPostPumped: screen.onPostPumped,
                name: p.join('screenshots', device.name, locale.languageCode, 'screenshot_$screenshotNumber'),
                size: device.size,
              );

              await screen.onTearDown?.call();
              await onTearDown?.call();

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

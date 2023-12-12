import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';

import 'common.dart';
import 'models.dart';

/// Generates a 512x app icon saved to `assets_dev/app_icons`
@isTest
void generateAppIcon({
  required AppIconBuilder onBuildIcon,
  bool? skip,
}) {
  testGoldens(
    'Generate app icon',
    (tester) async {
      await loadAppFonts();

      const size = Size(512, 512);
      await tester.pumpWidgetBuilder(
        SizedBox.fromSize(
          size: size,
          child: onBuildIcon(),
        ),
        surfaceSize: size,
      );
      await screenMatchesGolden(tester, 'app_icons/app_icon');

      moveGoldens('app_icons', replaceAllFiles: false);
    },
    skip: skip,
  );
}

/// Generates a 512x android app icon foreground saved to `assets_dev/app_icons`
/// The resulting icon has a transparent background with [padding] around [onBuildIcon]
/// In general [onBuildIcon] should also return an icon with transparent background
@isTest
void generateAppIconAndroidForeground({
  required AppIconBuilder onBuildIcon,
  EdgeInsets padding = const EdgeInsets.all(80),
  bool? skip,
}) {
  testGoldens(
    'Generate android icon foreground',
    (tester) async {
      await loadAppFonts();

      const size = Size(512, 512);
      await tester.pumpWidgetBuilder(
        SizedBox.fromSize(
          size: size,
          child: Padding(
            padding: padding,
            child: onBuildIcon(),
          ),
        ),
        surfaceSize: size,
        wrapper: (child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Material(
            color: Colors.transparent,
            child: child,
          ),
        ),
      );
      await screenMatchesGolden(tester, 'app_icons/android_icon_foreground');

      moveGoldens('app_icons', replaceAllFiles: false);
    },
    skip: skip,
  );
}

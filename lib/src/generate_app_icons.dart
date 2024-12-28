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
  testGoldensWithShadows(
    () => testGoldens(
      'Generate app icon',
      (tester) async {
        await loadAppFonts();

        const size = Size(512, 512);
        await tester.pumpWidgetBuilder(
          SizedBox.fromSize(
            size: size,
            child: onBuildIcon(size.shortestSide),
          ),
          surfaceSize: size,
        );
        await screenMatchesGolden(tester, 'app_icons/app_icon');

        moveGoldens('app_icons', replaceAllFiles: false);
      },
      skip: skip,
    ),
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
  testGoldensWithShadows(
    () => testGoldens(
      'Generate android icon foreground',
      (tester) async {
        await loadAppFonts();

        const size = Size(512, 512);
        await tester.pumpWidgetBuilder(
          SizedBox.fromSize(
            size: size,
            child: Padding(
              padding: padding,
              child: onBuildIcon(size.shortestSide),
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
    ),
  );
}

/// Generates a 824x macOS app icon in a 1024x frame with rounded edges and shadows saved to `assets_dev/app_icons`
@isTest
void generateAppIconMacOS({
  required AppIconBuilder onBuildIcon,
  bool? skip,
}) {
  testGoldensWithShadows(
    () => testGoldens(
      'Generate macOS icon',
      (tester) async {
        await loadAppFonts();

        const surfaceSize = Size(1024, 1024);
        const iconSize = Size(824, 824);
        final iconBorderRadius = BorderRadius.circular(iconSize.width * 0.2237);
        await tester.pumpWidgetBuilder(
          SizedBox.fromSize(
            size: surfaceSize,
            child: Center(
              child: SizedBox.fromSize(
                size: iconSize,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: iconBorderRadius,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff000000).withOpacity(0.3),
                        offset: const Offset(0.0, 10.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  // sha
                  child: ClipRRect(
                    borderRadius: iconBorderRadius,
                    child: onBuildIcon(iconSize.shortestSide),
                  ),
                ),
              ),
            ),
          ),
          surfaceSize: surfaceSize,
          // wrapper: (child) => CupertinoApp(
          //   debugShowCheckedModeBanner: false,
          //   home: child,
          // ),
          wrapper: (child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Material(
              color: Colors.transparent,
              child: child,
            ),
          ),
        );
        await screenMatchesGolden(tester, 'app_icons/app_icon_macos');

        moveGoldens('app_icons', replaceAllFiles: false);
      },
      skip: skip,
    ),
  );
}

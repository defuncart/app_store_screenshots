import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';

import 'common.dart';
import 'models.dart';

@isTest
void generateGooglePlayFeatureGraphic({
  required Iterable<Locale> locales,
  required GooglePlayFeatureGraphicBuilder onBuildGraphic,
  bool? skip,
}) {
  testGoldens(
    'Generate Google Play Feature Graphic',
    (tester) async {
      await loadAppFonts();

      const size = Size(1024, 500);
      for (final locale in locales) {
        final filename = 'google_play_assets/google_play_feature_graphic_${locale.languageCode}';
        await tester.pumpWidgetBuilder(
          SizedBox.fromSize(
            size: size,
            child: onBuildGraphic(locale),
          ),
          surfaceSize: size,
        );
        await screenMatchesGolden(tester, filename);
      }

      moveGoldens('google_play_assets');
    },
    skip: skip,
  );
}

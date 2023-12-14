import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:example/page1.dart';
import 'package:example/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  const textStyle = TextStyle(
    fontSize: 96,
    color: Colors.white,
  );

  generateAppStoreScreenshots(
    onSetUp: () {},
    config: ScreenshotsConfig(
      devices: DeviceType.values,
      locales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      backgroundColor: Colors.green,
      theme: lightTheme,
      textStyle: textStyle,
    ),
    screens: [
      ScreenshotScenario(
        onBuildScreen: () => const Page1(),
        text: {
          const Locale('en'): 'Light mode',
          const Locale('de'): 'Hellmodus',
        },
      ),
      ScreenshotScenario(
        onBuildScreen: () => const Page1(),
        text: {
          const Locale('en'): 'Dark mode',
          const Locale('de'): 'Dunkelmodus',
        },
        theme: darkTheme,
      ),
    ],
    onTearDown: () {},
    skip: false,
  );
}

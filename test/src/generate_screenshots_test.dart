import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:flutter/material.dart';

void main() {
  generateAppStoreScreenshots(
    config: ScreenshotsConfig(
      devices: DeviceType.values,
      locales: const [Locale('en')],
      background: ScreenshotBackground.solid(
        color: Colors.green,
      ),
      theme: ThemeData.light(),
      textStyle: const TextStyle(fontSize: 96, color: Colors.white),
    ),
    screens: [
      ScreenshotScenario(
        onBuildScreen: () => const Page1(),
        text: ScreenshotText(
          text: {
            const Locale('en'): 'Light mode',
            const Locale('de'): 'Hellmodus',
          },
        ),
      ),
      ScreenshotScenario(
        onBuildScreen: () => const Page1(),
        text: ScreenshotText(
          text: {
            const Locale('en'): 'Dark mode',
            const Locale('de'): 'Dunkelmodus',
          },
        ),
        theme: ThemeData.dark(),
      ),
    ],
  );
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.flutter_dash,
              size: 196,
            ),
            Text(
              'Hello World',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}

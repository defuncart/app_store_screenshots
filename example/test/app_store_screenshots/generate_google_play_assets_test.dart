import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:example/themes/theme.dart';
import 'package:flutter/material.dart';

void main() {
  final text = {
    const Locale('de'): 'Die neue App',
    const Locale('en'): 'The new app',
  };

  generateGooglePlayFeatureGraphic(
    locales: const [Locale('de'), Locale('en')],
    onBuildGraphic: (locale) => GooglePlayFeatureGraphics(
      text: text[locale] ?? '',
    ),
  );
}

class GooglePlayFeatureGraphics extends StatelessWidget {
  const GooglePlayFeatureGraphics({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: lightTheme,
      child: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.flutter_dash,
                size: 192,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  text,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 64,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

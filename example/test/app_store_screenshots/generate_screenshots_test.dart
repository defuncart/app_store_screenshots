import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:example/pages/bloc_page.dart';
import 'package:example/pages/page1.dart';
import 'package:example/pages/riverpod_page.dart';
import 'package:example/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const textStyle = TextStyle(
    fontSize: 96,
    color: Colors.white,
  );

  generateAppStoreScreenshots(
    config: ScreenshotsConfig(
      devices: DeviceType.values,
      locales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      background: ScreenshotBackground.solid(
        color: Colors.green,
      ),
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
      ScreenshotScenario(
        onBuildScreen: () => const RiverpodPage(),
        wrapper: (child) => ProviderScope(
          overrides: [
            itemsProvider.overrideWithValue(
              List.generate(
                10,
                (index) => 'Item ${index + 1}',
              ),
            ),
          ],
          child: child,
        ),
        text: {
          const Locale('en'): 'Riverpod',
          const Locale('de'): 'Riverpod',
        },
        background: ScreenshotBackground.gradient(
          gradient: const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Colors.white,
              Colors.green,
            ],
          ),
        ),
      ),
      ScreenshotScenario(
        onBuildScreen: () => const BlocPage(),
        wrapper: (child) => BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
          child: child,
        ),
        onPostPumped: (tester) async => await tester.tap(find.byType(FloatingActionButton).first),
        text: {
          const Locale('en'): 'bloc',
          const Locale('de'): 'bloc',
        },
        background: ScreenshotBackground.widget(
          widget: const TriangleBackground(
            color1: Colors.green,
            color2: Colors.white,
          ),
        ),
      ),
    ],
  );
}

class TriangleBackground extends StatelessWidget {
  const TriangleBackground({
    super.key,
    required this.color1,
    required this.color2,
  });

  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TriangleBackgroundPainter(
        color1: color1,
        color2: color2,
      ),
    );
  }
}

class TriangleBackgroundPainter extends CustomPainter {
  TriangleBackgroundPainter({
    required this.color1,
    required this.color2,
  });

  final Color color1;
  final Color color2;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..color = color1
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    final trianglePaint = Paint()
      ..color = color2
      ..style = PaintingStyle.fill;
    final trianglePath = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(trianglePath, trianglePaint);
  }

  @override
  bool shouldRepaint(TriangleBackgroundPainter oldDelegate) =>
      oldDelegate.color1 != color1 || oldDelegate.color2 != color2;
}

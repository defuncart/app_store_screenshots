import 'package:app_store_screenshots/src/models.dart';
import 'package:app_store_screenshots/src/models.internal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScreenshotForegroundOptionsExtension', () {
    group('merge', () {
      ScreenshotForegroundOptions? childOptions;
      ScreenshotForegroundOptions? parentOptions;

      test('when both child & parent are null, expect default', () {
        expect(childOptions.merge(parentOptions), const ScreenshotForegroundOptions.top());
      });

      test('when child is null & parent is not null, expect parent', () {
        parentOptions = const ScreenshotForegroundOptions.top();

        expect(childOptions.merge(parentOptions), const ScreenshotForegroundOptions.top());
      });

      test('when child is not null & parent is null, expect child', () {
        childOptions = const ScreenshotForegroundOptions.top();

        expect(childOptions.merge(parentOptions), const ScreenshotForegroundOptions.top());
      });

      test('when both child & parent are not null, expect correct merge', () {
        parentOptions = const ScreenshotForegroundOptions.top(
          textStyle: TextStyle(fontSize: 24),
        );
        childOptions = const ScreenshotForegroundOptions.bottom();

        expect(
          childOptions.merge(parentOptions),
          const ScreenshotForegroundOptions.bottom(
            padding: EdgeInsets.all(48),
            textStyle: TextStyle(fontSize: 24),
            spacer: 16,
          ),
        );
      });
    });
  });
}

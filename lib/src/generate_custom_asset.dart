import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';

import 'common.dart';

/// Generates a [size] asset containing [content] with [filename]
///
/// When [outputDirectory] is not null, the asset is moved after creation. When [replaceAllFiles] is true, the contents of [outputDirectory] are emptied before moving generated asset.
///
/// [completer] is optional and completed when asset is created and optional movement has occurred.
@isTest
void generateCustomAsset(
  String description, {
  required Size size,
  required Widget content,
  required String filename,
  String? outputDirectory,
  bool replaceAllFiles = false,
  Completer<void>? completer,
  bool? skip,
}) {
  testGoldensWithShadows(
    () => testGoldens(
      description,
      (tester) async {
        await loadAppFonts();

        await tester.pumpWidgetBuilder(
          SizedBox.fromSize(
            size: size,
            child: content,
          ),
          surfaceSize: size,
          // incase background is transparent
          wrapper: (child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Material(
              color: Colors.transparent,
              child: child,
            ),
          ),
        );
        await screenMatchesGolden(tester, filename);

        if (outputDirectory != null) {
          moveGoldens(outputDirectory, replaceAllFiles: replaceAllFiles);
        }
        completer?.complete();
      },
      skip: skip,
    ),
  );
}

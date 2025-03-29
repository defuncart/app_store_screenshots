import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

const defaultOutputDir = 'assets_dev';

/// Moves goldens from `test_dir/goldens/[dirName]` to `[to]/[dirName]`
/// When [replaceAllFiles] is true, `[to]/[dirName]` is firstly deleted
/// When [replaceAllFiles] is false, files are copied one-by-one
void moveGoldens(
  String dirName, {
  String to = defaultOutputDir,
  bool replaceAllFiles = true,
}) {
  // determine path of current test
  final basedir = (goldenFileComparator as LocalFileComparator).basedir;
  var testFolderPath = basedir.path.replaceAll(Directory.current.path, '');
  if (testFolderPath.startsWith('/')) {
    testFolderPath = testFolderPath.substring(1);
  }

  final goldenPath = p.join(testFolderPath, 'goldens');
  final sourcePath = p.join(goldenPath, dirName);
  final targetPath = p.join(to, dirName);

  // create output folder if necessary
  if (!Directory(targetPath).existsSync()) {
    Directory(targetPath).createSync(recursive: true);
  }

  if (replaceAllFiles) {
    // delete target folder if needed
    if (Directory(targetPath).existsSync()) {
      Directory(targetPath).deleteSync(recursive: true);
    }

    Directory(sourcePath).renameSync(targetPath);
  } else {
    for (final file in filesForDir(Directory(sourcePath))) {
      final newPath = file.path.replaceAll(sourcePath, targetPath);

      file.copySync(newPath);
      file.deleteSync();
    }
  }
  Directory(goldenPath).deleteSync(recursive: true);
}

@visibleForTesting
Iterable<File> filesForDir(Directory dir) => dir.listSync(recursive: true).whereType<File>();

/// Test [body] with shadows enabled & default tags
void testGoldensWithShadows<T>(T Function() body) => GoldenToolkit.runWithConfiguration(
      body,
      config: GoldenToolkitConfiguration(
        enableRealShadows: true,
        tags: const ['app_store_screenshots'],
      ),
    );

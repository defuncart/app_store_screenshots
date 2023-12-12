import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

/// Moves goldens from `test_dir/goldens/[dirName]` to `assets_dev/[dirName]`
/// When [replaceAllFiles] is true, assets_dev/[dirName] is firstly deleted
/// When [replaceAllFiles] is false, files are copied one-by-one
void moveGoldens(
  String dirName, {
  bool replaceAllFiles = true,
}) {
  // determine path of current test
  final basedir = (goldenFileComparator as LocalFileComparator).basedir;
  var testFolderPath = basedir.path.replaceAll(Directory.current.path, '');
  if (testFolderPath.startsWith('/')) {
    testFolderPath = testFolderPath.substring(1);
  }

  final goldenPath = p.join(testFolderPath, 'goldens', dirName);
  final outputPath = p.join('assets_dev', dirName);

  // create output folder if necessary
  if (!Directory(outputPath).existsSync()) {
    Directory(outputPath).createSync(recursive: true);
  }

  if (replaceAllFiles) {
    // delete target folder if needed
    if (Directory(outputPath).existsSync()) {
      Directory(outputPath).deleteSync(recursive: true);
    }

    Directory(goldenPath).renameSync(outputPath);
  } else {
    for (final file in filesForDir(Directory(goldenPath))) {
      final newPath = file.path.replaceAll(goldenPath, outputPath);

      file.copySync(newPath);
      file.deleteSync();
    }
  }
}

@visibleForTesting
Iterable<File> filesForDir(Directory dir) => dir.listSync(recursive: true).whereType<File>();

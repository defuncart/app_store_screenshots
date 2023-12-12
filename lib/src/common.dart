import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

/// Moves goldens from `test_dir/goldens/[dirName]` to `assets_dev/[dirName]`
void moveGoldens(String dirName) {
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

  // delete target folder if needed
  if (Directory(outputPath).existsSync()) {
    Directory(outputPath).deleteSync(recursive: true);
  }

  Directory(goldenPath).renameSync(outputPath);
}

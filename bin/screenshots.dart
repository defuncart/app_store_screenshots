// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path/path.dart' as p;

Future<void> main() async {
  if (!await File('pubspec.yaml').exists()) {
    print('Not a valid flutter project');
    exit(1);
  }

  if (!await Directory(p.join('test', 'app_store_screenshots')).exists()) {
    print('Folder ${p.join('test', 'app_store_screenshots')} not found. Please see README for instructions');
    exit(1);
  }

  if (await Directory('.fvm').exists()) {
    Process.run('fvm', [
      'flutter',
      'test',
      'test/app_store_screenshots/',
      '--update-goldens',
    ]).then((result) => print(result.stdout));
  } else {
    Process.run('flutter', [
      'test',
      'test/app_store_screenshots/',
      '--update-goldens',
    ]).then((result) => print(result.stdout));
  }
}

import 'dart:io';

import 'package:flutter/services.dart';

/// Loads a font called [name] from [path]
///
/// Font can use later referenced via 'fontFamily'
Future<void> loadFont({
  required String path,
  required String name,
}) async {
  final file = File(path);
  final byteData = ByteData.view(file.readAsBytesSync().buffer);
  final fontLoader = FontLoader(name)..addFont(Future.value(byteData));
  await fontLoader.load();
}

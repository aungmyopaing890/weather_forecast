import 'dart:io';

String readJson(String name) {
  final file = File('test/helper/assets/$name');
  return file.readAsStringSync();
}

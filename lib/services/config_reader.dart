import 'dart:io';

class ConfigReader {
  String read() {
    return File('menusc.yaml').readAsStringSync();
  }
}

import 'dart:io';

class ConfigReader {
  String read() {
    return File('config.yaml').readAsStringSync();
  }
}

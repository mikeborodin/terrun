import 'dart:io';

import 'package:terrun/services/services.dart';

class ConfigReader {
  final _filename = 'terrun.yaml';
  final Env env;

  ConfigReader(this.env);

  String? read({String? customConfigPath}) {
    final configCandidates = [
      '${env.home}/.config/terrun/',
      './',
    ];
    final firstFoundConfigPath = configCandidates.map((dir) => dir + _filename).firstWhere(
          (file) => File(file).existsSync(),
          orElse: () => '',
        );
    try {
      final file = File(customConfigPath ?? firstFoundConfigPath);
      return file.readAsStringSync();
    } catch (_) {
      return null;
    }
  }
}

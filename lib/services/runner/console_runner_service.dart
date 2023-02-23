import 'dart:io';

import 'package:menusc/services/runner/runner_service.dart';

class ProcessRunnerService implements RunnerService {
  @override
  Future<String> run(String command) async {
    final result = await Process.run(Platform.environment['SHELL'] ?? 'bash', [
      '-c',
      command,
    ]);

    if (result.exitCode == 0) {
      return result.stdout;
    } else {
      return result.stderr;
    }
  }
}

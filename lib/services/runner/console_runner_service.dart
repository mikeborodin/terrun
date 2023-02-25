import 'dart:io';

import 'package:menusc/services/runner/runner_service.dart';

class ProcessRunnerService implements RunnerService {
  @override
  Future<String> run(String command) async {
    final precommand =
        'osascript -e \'tell application "System Events" to key code 24 using {shift down, control down}\''; 
    final result = await Process.run(Platform.environment['SHELL'] ?? 'bash', [
      '-c',
      '$precommand && $command',
    ]);

    if (result.exitCode == 0) {
      return result.stdout;
    } else {
      return result.stderr;
    }
  }
}

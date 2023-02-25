import 'dart:io';

import 'package:menusc/core/core.dart';
import 'package:menusc/services/runner/runner_service.dart';

class ProcessRunnerService implements RunnerService {
  @override
  Future<String> run(String command, Hooks hooks) async {
    final precommand = hooks.preCommand;
    final result = await Process.run(Platform.environment['SHELL'] ?? 'bash', [
      '-c',
      precommand.isNotEmpty ? '$precommand && $command' : command,
    ]);

    if (result.exitCode == 0) {
      return result.stdout;
    } else {
      return result.stderr;
    }
  }
}

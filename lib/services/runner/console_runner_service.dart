import 'dart:io';

import 'package:menusc/core/core.dart';
import 'package:menusc/services/runner/runner_service.dart';

class ProcessRunnerService implements RunnerService {
  @override
  Future<String> run(String command, Hooks hooks) async {
    final preRun = hooks.preRun.map((hook) => hook.command).join(' && ');
    final postRun = hooks.postRun.map((hook) => hook.command).join(' && ');
    final shell = Platform.environment['SHELL'] ?? 'bash';

    final result = await Process.run(shell, [
      '-c',
      preRun.isNotEmpty ? '$preRun && $command' : command,
    ]);

    if (postRun.isNotEmpty) {
      final _ = await Process.run(shell, [
        '-c',
        postRun,
      ]);
    }

    if (result.exitCode == 0) {
      return result.stdout;
    } else {
      return result.stderr;
    }
  }
}

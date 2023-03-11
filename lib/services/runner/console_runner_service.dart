import 'package:terrun/core/core.dart';
import 'package:terrun/services/runner/runner_service.dart';
import 'package:terrun/services/shell/shell_service.dart';

class ProcessRunnerService implements RunnerService {
  final ShellService _shell;

  ProcessRunnerService(this._shell);
  @override
  Future<String> run(String command, Hooks hooks) async {
    final preRun = hooks.preRun.map((hook) => hook.command).join(' && ');
    final postRun = hooks.postRun.map((hook) => hook.command).join(' && ');

    final result = await _shell.run(preRun.isNotEmpty ? '$preRun && $command' : command);

    if (postRun.isNotEmpty) {
      final _ = await _shell.run(postRun);
    }

    if (result.exitCode == 0) {
      return result.stdout;
    } else {
      return result.stderr;
    }
  }
}

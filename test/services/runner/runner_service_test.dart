import 'package:terrun/core/core.dart';
import 'package:terrun/services/runner/console_runner_service.dart';
import 'package:terrun/services/runner/runner_service.dart';
import 'package:terrun/services/shell/shell_service.dart';
import 'package:terrun/services/shell/shell_service_impl.dart';
import 'package:test/test.dart';

void main() {
  final ShellService shell = ShellServiceImpl();
  final RunnerService runner = ProcessRunnerService(shell);
  test('run should execute the shell command', () async {
    final output = await runner.run('print "success"', Hooks([], []));
    expect(output, 'success\n');
  });
  test('it should be possible to specify hook to run before the command', () async {
    final output = await runner.run(
      'print "success"',
      Hooks(
        [
          CommandHook(
            'print "hook"',
          ),
        ],
        [],
      ),
    );
    expect(output, 'hook\nsuccess\n');
  });
}

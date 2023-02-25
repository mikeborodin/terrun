import 'package:menusc/core/core.dart';
import 'package:menusc/services/runner/console_runner_service.dart';
import 'package:menusc/services/runner/runner_service.dart';
import 'package:test/test.dart';

void main() {
  final RunnerService runner = ProcessRunnerService();
  test('run should execute the shell command', () async {
    final output = await runner.run('print "success"', Hooks(''));
    expect(output, 'success\n');
  });
  test('it should be possible to specify hook to run before the command', () async {
    final output = await runner.run('print "success"', Hooks('print "hook"'));
    expect(output, 'hook\nsuccess\n');
  });
}

import 'package:menusc/services/runner/console_runner_service.dart';
import 'package:menusc/services/runner/runner_service.dart';
import 'package:test/test.dart';

void main() {
  final RunnerService runner = ProcessRunnerService();
  test('run should execute the shell command', () async {
    final output = await runner.run('print "success"');
    expect(output, 'success\n');
  });
}

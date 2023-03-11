import 'package:args/command_runner.dart';
import 'package:terrun/features/configure/configure.dart';
import 'package:terrun/features/loop.dart';
import 'package:terrun/services/services.dart';
import 'package:terrun/services/shell/shell_service.dart';
import 'package:terrun/services/shell/shell_service_impl.dart';

Future<void> app(List<String> args) async {
  var env = Env.load();

  final ShellService shell = ShellServiceImpl();
  final RunnerService shellRunner = ProcessRunnerService(shell);
  final DisplayService display = ConsoleDisplaySevice()..init();

  final commandRunner = CommandRunner(
    'terrun',
    'run anything with minimum keystrokes',
  );

  commandRunner
    ..addCommand(ConfigureCommand(
      display,
      shell,
      env,
    ))
    ..addCommand(LoopCommand(
      shellRunner,
      display,
      env,
    ));

  await commandRunner.run(args);
}

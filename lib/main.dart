import 'package:args/command_runner.dart';

import 'features/features.dart';
import 'services/services.dart';

Future<void> app(List<String> args) async {
  var env = Env.load();
  final ShellService shell = ShellServiceImpl();
  final RunnerService shellRunner = ProcessRunnerService(shell);
  final DisplayService display = ConsoleDisplaySevice()..init();

  final runner = CommandRunner(
    'terrun',
    'run anything with minimum keystrokes',
  )
    ..addCommand(ConfigureCommand(
      display,
      shell,
      env,
    ))
    ..addCommand(LoopCommand(
      shellRunner,
      display,
      env,
    ))
    ..addCommand(
      UpdateCommand(
        shell,
        display,
      ),
    );

  await runner.run(args);
}

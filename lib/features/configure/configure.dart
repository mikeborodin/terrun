import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:terrun/services/services.dart';

import 'defaults.dart';

class ConfigureCommand extends Command<void> {
  final DisplayService display;
  final ShellService shell;
  final Env env;

  ConfigureCommand(
    this.display,
    this.shell,
    this.env,
  );

  @override
  String get description => 'Creates your starter terrun.yaml file if it doesn\'t exist.';

  @override
  String get name => 'configure';

  @override
  Future<void> run() async {
    var defaultLocation = '${env.home}/.config/terrun/terrun.yaml';
    if (File(defaultLocation).existsSync()) {
      display.drawMessage('File $defaultLocation already exists');
      return;
    }

    final lines = [
      'mkdir -p ~/.config/terrun',
      'touch $defaultLocation',
      'echo \'$defaultsYaml\' > $defaultLocation',
    ];

    display.drawMessage('Writing config file...', type: MessageType.success);
    for (final line in lines) {
      final result = await shell.run(line);
      if (result.exitCode != 0) {
        display.drawMessage(
          'error while executing "$line":',
          type: MessageType.error,
        );
        display.drawMessage(result.stdout);
        display.drawMessage(result.stderr);
      }
    }
  }
}

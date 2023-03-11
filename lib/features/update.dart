import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:terrun/services/display/display.dart';
import 'package:terrun/services/shell/shell_service.dart';

class UpdateCommand extends Command<void> {
  final ShellService _shell;
  final DisplayService _display;

  UpdateCommand(
    this._shell,
    this._display,
  );
  @override
  String get description => 'Updates to the latest version';

  @override
  String get name => 'update';

  @override
  FutureOr<void>? run() async {
    var script = [
      'git -C \$(brew --repository mikeborodin/terrun) pull',
      'brew upgrade terrun',
    ];
    for (final line in script) {
      final result = await _shell.run(line);
      if (result.exitCode == 0) {
        _display.drawMessage(
          '"$line" finished succesfully ',
          type: MessageType.success,
          clear: false,
        );
      } else {
        _display.drawMessage(
          'Error while running $line\n${result.stderr}',
          type: MessageType.error,
          clear: false,
        );
      }
    }
  }
}

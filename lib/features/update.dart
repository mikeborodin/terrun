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
    final updated = await Stream.fromIterable(script).asyncMap((line) => _shell.run(line)).any(
          (element) => element.stdout != 0,
        );
    if (updated) {
      _display.drawMessage(
        'Updated successfully',
        type: MessageType.success,
      );
    } else {
      _display.drawMessage(
        'Error while running lines $script',
        type: MessageType.error,
      );
    }
  }
}

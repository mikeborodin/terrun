import 'dart:io';

import 'package:terrun/services/display/theme.dart';
import 'package:terrun/services/services.dart';

import '../../core/core.dart';

class ConsoleDisplaySevice implements DisplayService {
  final theme = Theme(
    info: 15,
    error: 1,
    success: 2,
  );

  @override
  void drawMatchingCommands(
    String input,
    Map<String, Command> commands,
  ) {
    _clear();
    _drawInput(input);

    final matchingCommands = commands.entries.where(
      (entry) => entry.key.startsWith(input),
    );
    for (final entry in matchingCommands) {
      final shortcut = entry.key;
      final command = entry.value;

      String result = '';
      if (command.isGroup) {
        result = '\n${command.name}:'.colored(6, bg: 0);
      } else {
        result = '${'[$shortcut]'.colored(2)} ${command.name} ${'${command.script}'.colored(244)}'
            .colored(15, bg: 0);
      }
      stdout.writeln(result);
    }
  }

  @override
  void init() {
    stdin.echoMode = false;
    stdin.echoNewlineMode = false;
    stdin.lineMode = false;
    _clear();
  }

  @override
  void clear() => _clear();

  void _clear() => print('\x1B[2J\x1B[0;0H');

  void _drawInput(String input) {
    stdout.writeln('----------------------');
    stdout.writeln('Input: ${input.colored(15, bg: 0)}');
    stdout.writeln('----------------------');
  }

  @override
  void drawMessage(
    String message, {
    MessageType? type = MessageType.info,
    bool clear = true,
  }) {
    if (clear) {
      _clear();
    }
    final color = {
          MessageType.success: theme.success,
          MessageType.error: theme.error,
          MessageType.info: theme.info,
        }[type] ??
        theme.info;

    stderr.writeln(message.colored(color));
  }
}

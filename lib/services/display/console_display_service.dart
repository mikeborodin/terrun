import 'dart:io';

import 'package:menusc/services/services.dart';

import '../../core/core.dart';

class ConsoleDisplaySevice implements DisplayService {
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
result = '\n${command.name}:'.colored(6);
      } else {
        result = '${'[$shortcut]'.colored(2)} ${command.name} ${'${command.script}'.colored(244)}';
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

  void _clear() => print("\x1B[2J\x1B[0;0H");

  void _drawInput(String input) {
    stdout.writeln('----------------------');
    stdout.writeln('Input: ${input.colored(2)}');
    stdout.writeln('----------------------');
  }
}
